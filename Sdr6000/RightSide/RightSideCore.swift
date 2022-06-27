//
//  RightSideCore.swift
//  Sdr6000
//
//  Created by Douglas Adams on 6/19/22.
//

import ComposableArchitecture

import Api6000
import Shared

// ----------------------------------------------------------------------------
// MARK: - Structs and Enums


// ----------------------------------------------------------------------------
// MARK: - State, Actions & Environment

public struct RightSideState: Equatable {
  public var rxIsOn: Bool
  public var txIsOn: Bool
  public var ph1IsOn: Bool
  public var ph2IsOn: Bool
  public var cwIsOn: Bool
  public var eqIsOn: Bool
  public var subViewSelection: String
  public var flagMinimized: Bool
  public var slice: Slice
  public var flagState: FlagState?
  public var forceUpdate = false
  
  public init
  (
    rxIsOn: Bool = false,
    txIsOn: Bool = false,
    ph1IsOn: Bool = false,
    ph2IsOn: Bool = false,
    cwIsOn: Bool = false,
    eqIsOn: Bool = false,
    subViewSelection: String = "none",
    flagMinimized: Bool = false,
    slice: Slice
  )
  {
    self.rxIsOn = rxIsOn
    self.txIsOn = txIsOn
    self.ph1IsOn = ph1IsOn
    self.ph2IsOn = ph2IsOn
    self.cwIsOn = cwIsOn
    self.eqIsOn = eqIsOn
    self.subViewSelection = subViewSelection
    self.flagMinimized = flagMinimized
    self.slice = slice
  }
}

public enum RightSideAction: Equatable {
  
  // UI controls
  case toggle(WritableKeyPath<RightSideState, Bool>)
  case subViewSelectionChanged(String)
  case sliceLetterClicked
  case splitClicked
  case rxAntennaSelection(String)
  case txAntennaSelection(String)
  case nbClicked
  case nrClicked
  case anfClicked
  case qskClicked
  case frequencyChanged(String)
  case audioGainChanged(Int)
  case audioPanChanged(Int)
  case agcModeChanged(String)
  case agcThresholdChanged(Int)
}

public struct RightSideEnvironment {
  
  public init() {}
}

// ----------------------------------------------------------------------------
// MARK: - Reducer

public let rightSideReducer = Reducer<RightSideState, RightSideAction, RightSideEnvironment>
{ state, action, environment in
  //  .combine(
  //  flagReducer
  //    .optional()
  //    .pullback(
  //      state: \RightSideState.flagState,
  //      action: /RightSideAction.flagAction,
  //      environment: { _ in FlagEnvironment() }
  //    ),
  //  Reducer
  
  switch action {
    
  case .toggle(let keyPath):
    // handles all buttons with a Bool state
    state[keyPath: keyPath].toggle()
    return .none
    
  case .subViewSelectionChanged(let selection):
    if state.subViewSelection == "none" {
      state.subViewSelection = selection
    } else if state.subViewSelection == selection {
      state.subViewSelection = "none"
    } else {
      state.subViewSelection = selection
    }
    return .none
    
  case .sliceLetterClicked:
    // ignored by RightSide
    //    state.flagMinimized.toggle()
    return .none
    
  case .rxAntennaSelection(let antenna):
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .rxAnt, value: antenna)
    return .none
    
  case .txAntennaSelection(let antenna):
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .txAnt, value: antenna)
    return .none
    
  case .splitClicked:
    return .none
    
  case .nbClicked:
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .nbEnabled, value: true )
    return .none
    
  case .nrClicked:
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .nrEnabled, value: true)
    return .none
    
  case .anfClicked:
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .anfEnabled, value: true)
    return .none
    
  case .qskClicked:
    // FIXME: no command, modify directly
    //    Slice.setProperty(radio: state.model.radio!, id: state.model.radio!.activeSlice!, property: .qskEnabled, value: !state.model.slices[id: state.model.radio!.activeSlice!]!.qskEnabled)
    return .none
    
  case .frequencyChanged(let frequency):
    print("-----> frequency = ", frequency)
    return .none
    
  case .audioGainChanged(let gain):
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .audioGain, value: gain)
    return .none

  case .audioPanChanged(let pan):
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .audioGain, value: pan)
    return .none

  case .agcModeChanged(let mode):
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .agcMode, value: mode)
    return .none

  case .agcThresholdChanged(let threshold):
    Slice.setProperty(radio: Model.shared.radio!, id: state.slice.id, property: .agcThreshold, value: threshold)
    return .none
  }
}
//  .debug("-----> RIGHTSIDEVIEW")
