//
//  SdrCore.swift
//  
//
//  Created by Douglas Adams on 4/23/22.
//

import Combine
import ComposableArchitecture
import Dispatch
import SwiftUI

import Api6000
import ClientView
import LoginView
import LogView
import PickerView
import RemoteView
import Shared
import SecureStorage
import XCGWrapper

// ----------------------------------------------------------------------------
// MARK: - Structs and Enums

public typealias Logger = (PassthroughSubject<LogEntry, Never>, LogLevel) -> Void

public struct TcpMessage: Equatable, Identifiable {
  public var id = UUID()
  var direction: TcpMessageDirection
  var text: String
  var color: Color
  var timeInterval: TimeInterval
}

public struct DefaultValue: Equatable, Codable {
  public var serial: String
  public var source: String
  public var station: String?
  
  public init
  (
    _ serial: String,
    _ source: PacketSource,
    _ station: String?
  )
  {
    self.serial = serial
    self.source = source.rawValue
    self.station = station
  }
  enum CodingKeys: String, CodingKey {
    case source
    case serial
    case station
  }
}

public enum ConnectionMode: String {
  case both
  case local
  case none
  case smartlink
}

// ----------------------------------------------------------------------------
// MARK: - State, Actions & Environment

public struct SdrState: Equatable {
  // State held in User Defaults
  public var connectionMode: ConnectionMode { didSet { UserDefaults.standard.set(connectionMode.rawValue, forKey: "connectionMode") } }
  public var guiDefault: DefaultValue? { didSet { setDefaultValue(guiDefault) } }
  public var smartlinkEmail: String { didSet { UserDefaults.standard.set(smartlinkEmail, forKey: "smartlinkEmail") } }
//  public var useDefault: Bool
  
  // normal state
  public var alert: AlertState<SdrAction>?
  public var clientState: ClientState?
  public var forceUpdate = false
  public var forceWanLogin = false
  public var initialized = false
  public var isConnected = false
  public var leftSideVisible = false
  public var leftSideState = LeftSideState()
  public var lanListener: LanListener?
  public var loginState: LoginState? = nil
  public var model: Model { Model.shared }
  public var pendingWanId: UUID?
  public var pickerState: PickerState? = nil
  public var rightSideVisible = false
  public var rightSideState = RightSideState()

  public var tcp = Tcp()
  public var wanListener: WanListener?
  
  public init(
    connectionMode: ConnectionMode = ConnectionMode(rawValue: UserDefaults.standard.string(forKey: "connectionMode") ?? "local") ?? .local,
    guiDefault: DefaultValue? = getDefaultValue(),
    smartlinkEmail: String = UserDefaults.standard.string(forKey: "smartlinkEmail") ?? ""
  ) {
    self.connectionMode = connectionMode
    self.guiDefault = guiDefault
    self.smartlinkEmail = smartlinkEmail
  }
}

public enum SdrAction: Equatable {
  // initialization
  case onAppear
  
  // UI controls
  case connectButton
  
  // subview/sheet/alert related
  case alertDismissed
  case clientAction(ClientAction)
  case loginAction(LoginAction)
  case pickerAction(PickerAction)
  case rightSideAction(RightSideAction)
  case leftSideAction(LeftSideAction)
  
  // Effects related
  case cancelEffects
  case checkConnectionStatus(UUID)
  case clientChangeReceived(ClientUpdate)
  case finishInitialization
  case logAlertReceived(LogEntry)
  case meterReceived(Meter)
  case openSelection(UUID, Handle?)
  case packetChangeReceived(PacketUpdate)
  case sidebarLeftClicked
  case sidebarRightClicked
  case testResult(SmartlinkTestResult)
  case tcpMessage(TcpMessage)
  case wanStatus(WanStatus)
}
public struct SdrEnvironment {
  
  public init() {}
}

public let sdrReducer = Reducer<SdrState, SdrAction, SdrEnvironment>.combine(
  leftSideReducer
//    .optional()
    .pullback(
      state: \SdrState.leftSideState,
      action: /SdrAction.leftSideAction,
      environment: { _ in LeftSideEnvironment() }
    ),
  rightSideReducer
//    .optional()
    .pullback(
      state: \SdrState.rightSideState,
      action: /SdrAction.rightSideAction,
      environment: { _ in RightSideEnvironment() }
    ),
  clientReducer
    .optional()
    .pullback(
      state: \SdrState.clientState,
      action: /SdrAction.clientAction,
      environment: { _ in ClientEnvironment() }
    ),
  loginReducer
    .optional()
    .pullback(
      state: \SdrState.loginState,
      action: /SdrAction.loginAction,
      environment: { _ in LoginEnvironment() }
    ),
  pickerReducer
    .optional()
    .pullback(
      state: \SdrState.pickerState,
      action: /SdrAction.pickerAction,
      environment: { _ in PickerEnvironment() }
    ),
  Reducer { state, action, environment in
    
    switch action {
    case .onAppear:
      // if the first time, start various effects
      if state.initialized == false {
        state.initialized = true
        // instantiate the Logger,
        _ = XCGWrapper(logLevel: .debug)
        //        _ = environment.logger(LogProxy.sharedInstance.logPublisher, .debug)
        // start subscriptions
        return .merge(
          subscribeToPackets(),
          subscribeToWan(),
//          subscribeToSent(state.tcp),
//          subscribeToReceived(state.tcp),
//          subscribeToMeters(),
          subscribeToLogAlerts(),
          Effect(value: .finishInitialization))
      }
      return .none
      
    case .finishInitialization:
      // needed when coming from other than .onAppear
      state.lanListener?.stop()
      state.lanListener = nil
      state.wanListener?.stop()
      state.wanListener = nil
      
      // start / stop listeners as appropriate for the Mode
      switch state.connectionMode {
      case .local:
        state.model.removePackets(ofType: .smartlink)
        state.lanListener = LanListener()
        state.lanListener!.start()
      case .smartlink:
        state.model.removePackets(ofType: .local)
        state.wanListener = WanListener()
        if state.forceWanLogin || state.wanListener!.start(state.smartlinkEmail) == false {
          state.loginState = LoginState(heading: "Smartlink Login required")
        }
      case .both:
        state.lanListener = LanListener()
        state.lanListener!.start()
        state.wanListener = WanListener()
        if state.forceWanLogin || state.wanListener!.start(state.smartlinkEmail) == false {
          state.loginState = LoginState(heading: "Smartlink Login required")
        }
      case .none:
        state.model.removePackets(ofType: .local)
        state.model.removePackets(ofType: .smartlink)
      }
      return .none
      
    case .connectButton:
      // current state?
      if state.model.radio == nil {
        // NOT connected, check for a default
        if UserDefaults.standard.bool(forKey: "useDefault"), let packetId = hasDefault(state) {
          // YES, is it Wan?
          if state.model.packets[id: packetId]?.source == .smartlink {
            // YES, reply will generate a wanStatus action
            state.pendingWanId = packetId
            state.wanListener!.sendWanConnectMessage(for: state.model.packets[id: packetId]!.serial, holePunchPort: state.model.packets[id: packetId]!.negotiatedHolePunchPort)
            return .none
            
          } else {
            // NO, check for other connections
            return Effect(value: .checkConnectionStatus(packetId))
          }
          
        } else {
          // no default, or failed to find a match, open the Picker
          state.pickerState = PickerState(pickables: getPickables(state),
                                          isGui: true,
                                          defaultId: nil,
                                          selectedId: nil,
                                          testResult: false)
          return .none
        }
        
      } else {
        // CONNECTED, disconnect
        state.model.radio?.disconnect()
        state.model.radio = nil
        state.isConnected = false
        state.leftSideVisible = false
        state.rightSideVisible = false
        return .none
      }
      
    case .packetChangeReceived(_):
      // a packet change has been observed
      if state.pickerState != nil {
        state.pickerState!.pickables = getPickables(state)
      }
      return .none
      
    case .clientChangeReceived(let update):
      // a guiClient change has been observed
      return .none
      
    case .cancelEffects:
      return .cancel(
        ids:
          [
            LogAlertSubscriptionId(),
//            SentSubscriptionId(),
//            ReceivedSubscriptionId(),
//            MeterSubscriptionId()
          ]
      )
      
    case .checkConnectionStatus(let packetId):
      // making a Gui connection and other Gui connections exist?
      if state.model.packets[id: packetId]!.guiClients.count > 0 {
        // YES, may need a disconnect, let the user choose
        var stations = [String]()
        var handles = [Handle]()
        if let packet = state.model.packets[id: packetId] {
          for client in packet.guiClients {
            stations.append(client.station)
            handles.append(client.handle)
          }
        }
        state.clientState = ClientState(selectedId: packetId, stations: stations, handles: handles)
        return .none
        
      } else {
        // NO, proceed to opening
        return Effect(value: .openSelection(packetId, nil))
      }
      
    case .logAlertReceived(let logEntry):
      // a Warning or Error has been logged.
      // exit any sheet states
      state.pickerState = nil
      state.loginState = nil
      // alert the user
      state.alert = .init(title: TextState("\(logEntry.level == .warning ? "A Warning" : "An Error") was logged:"),
                          message: TextState(logEntry.msg))
      
      return .none
      
    case .meterReceived(let meter):
      // an updated meter value has been received
      state.forceUpdate.toggle()
      return .none
      
    case .openSelection(let packetId, let disconnectHandle):
      // open the selected packet, optionally disconnect another station
      if let packet = state.model.packets[id: packetId] {
        // instantiate a Radio object
        state.model.radio = Radio(packet,
                                  connectionType: .gui,
                                  stationName: "Mac",
                                  programName: "Api6000Tester",
                                  disconnectHandle: disconnectHandle,
                                  testerModeEnabled: true)
        // try to connect
        if state.model.radio!.connect(packet) {
          state.isConnected = true
        } else {
          // failed
          state.model.radio = nil
          state.alert = AlertState(title: TextState("Failed to connect to Radio \(packet.nickname)"))
        }
      }
      return .none
      
    case .testResult(let result):
      // a test result has been received
      state.pickerState?.testResult = result.success
      return .none
      
    case .tcpMessage(let message):
      
      // FIXME:
      
      print(message.text)
      
      // a TCP messages (either sent or received) has been captured
      // ignore sent "ping" messages unless showPings is true
      //    if message.direction == .sent && message.text.contains("ping") && state.showPings == false { return .none }
      //    // add the message to the collection
      //    state.messages.append(message)
      //    // re-filter
      //    state.filteredMessages = filterMessages(state, state.messagesFilterBy, state.messagesFilterByText)
      return .none
      
    case .wanStatus(let status):
      // a WanStatus message has been received, was it successful?
      if state.pendingWanId != nil && status.type == .connect && status.wanHandle != nil {
        // YES, set the wan handle
        state.model.packets[id: state.pendingWanId!]!.wanHandle = status.wanHandle!
        // check for other connections
        return Effect(value: .checkConnectionStatus(state.pendingWanId!))
      }
      return .none
      
      // ----------------------------------------------------------------------------
      // MARK: - Picker Actions (PickerView -> ApiView)
      
    case .pickerAction(.cancelButton):
      // CANCEl, close the Picker sheet
      state.pickerState = nil
      return .none
      
    case .pickerAction(.connectButton( _, let packetId, _)):
      // CONNECT, close the Picker sheet
      state.pickerState = nil
      // is it Smartlink?
      if state.model.packets[id: packetId]?.source == .smartlink {
        // YES, send the Wan Connect message
        state.pendingWanId = packetId
        state.wanListener!.sendWanConnectMessage(for: state.model.packets[id: packetId]!.serial, holePunchPort: state.model.packets[id: packetId]!.negotiatedHolePunchPort)
        // the reply to this will generate a wanStatus action
        return .none
        
      } else {
        // check for other connections
        return Effect(value: .checkConnectionStatus(packetId))
      }
      
    case .pickerAction(.defaultButton( _, let packetId, _)):
      // SET / RESET the default, valid Id?
      if let packet = state.model.packets[id: packetId] {
        // YES
        let newValue =  DefaultValue(packet.serial, packet.source, nil)
        if state.guiDefault == newValue {
          state.guiDefault = nil
        } else {
          state.guiDefault = newValue
        }
      }
      return .none
      
    case .pickerAction(.testButton(let id, let packetId)):
      // TEST BUTTON, send a Test request
      state.wanListener!.sendSmartlinkTest(state.model.packets[id: packetId]!.serial)
      // reply will generate a testResult action
      return subscribeToTest()
      
    case .pickerAction(_):
      // IGNORE ALL OTHER picker actions
      return .none
      
      // ----------------------------------------------------------------------------
      // MARK: - Alert Action: (Alert is closed)
      
    case .alertDismissed:
      state.alert = nil
      return .none
      
      // ----------------------------------------------------------------------------
      // MARK: - ClientView Actions (ClientView -> ApiView)
      
    case .clientAction(.cancelButton):
      // CANCEL
      state.clientState = nil
      // additional processing upstream
      return .none
      
    case .clientAction(.connect(let packetId, let handle)):
      // CONNECT
      state.clientState = nil
      return Effect(value: .openSelection(packetId, handle))
      
      // ----------------------------------------------------------------------------
      // MARK: - LoginView Actions (LoginView -> ApiView)
      
    case .loginAction(.cancelButton):
      // CANCEL
      state.loginState = nil
      return .none
      
    case .loginAction(.loginButton(let user, let pwd)):
      // LOGIN
      state.loginState = nil
      // save the credentials
      let secureStore = SecureStore(service: "ApiViewer")
      _ = secureStore.set(account: "user", data: user)
      _ = secureStore.set(account: "pwd", data: pwd)
      state.smartlinkEmail = user
      // try a Smartlink login
      if state.wanListener!.start(using: LoginResult(user, pwd: pwd)) {
        state.forceWanLogin = false
      } else {
        state.alert = AlertState(title: TextState("Smartlink login failed"))
      }
      return .none
      
    case .loginAction(_):
      // IGNORE ALL OTHER login actions
      return .none

    case .sidebarLeftClicked:
      state.leftSideVisible.toggle()
      return .none

    case .sidebarRightClicked:
      state.rightSideVisible.toggle()
      return .none
      
    case .rightSideAction(_):
      return .none
    
    case .leftSideAction(_):
      return .none
    }
  }
)
//  .debug("-----> SDRVIEW")

// ----------------------------------------------------------------------------
// MARK: - Helper methods

/// Read the user defaults entry for a default connection and transform it into a DefaultConnection struct
/// - Parameters:
///    - type:         gui / nonGui
/// - Returns:         a DefaultValue struct or nil
public func getDefaultValue() -> DefaultValue? {
  let key = "guiDefault"
  
  if let defaultData = UserDefaults.standard.object(forKey: key) as? Data {
    let decoder = JSONDecoder()
    if let defaultValue = try? decoder.decode(DefaultValue.self, from: defaultData) {
      return defaultValue
    } else {
      return nil
    }
  }
  return nil
}

/// Write the user defaults entry for a default connection using a DefaultConnection struct
/// - Parameters:
///    - type:        gui / nonGui
///    - value:       a DefaultValue struct  to be encoded and written to user defaults
func setDefaultValue(_ value: DefaultValue?) {
  let key = "guiDefault"
  
  if value == nil {
    UserDefaults.standard.removeObject(forKey: key)
  } else {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(value) {
      UserDefaults.standard.set(encoded, forKey: key)
    } else {
      UserDefaults.standard.removeObject(forKey: key)
    }
  }
}

/// Determine if there is default radio connection
/// - Parameter state:  ApiCore state
/// - Returns:          a PacketId  (if any)
func hasDefault(_ state: SdrState) -> UUID? {
  if let defaultValue = state.guiDefault {
    for packet in state.model.packets where defaultValue.source == packet.source.rawValue && defaultValue.serial == packet.serial {
      // found one
      return packet.id
    }
  }
  // NO default or failed to find a match
  return nil
}

/// Produce an IdentifiedArray of items that can be picked
/// - Parameter state:  ApiCore state
/// - Returns:          an array of items that can be picked
func getPickables(_ state: SdrState) -> IdentifiedArrayOf<Pickable> {
  var pickables = IdentifiedArrayOf<Pickable>()
  // GUI
  for packet in state.model.packets {
    pickables.append( Pickable(id: packet.id,
                               packetId: packet.id,
                               isLocal: packet.source == .local,
                               name: packet.nickname,
                               status: packet.status,
                               station: packet.guiClientStations,
                               isDefault: packet.serial == state.guiDefault?.serial && packet.source.rawValue == state.guiDefault?.source)
    )
  }
  return pickables
}

func connectButon() {
  print("ConnectButton")
}
