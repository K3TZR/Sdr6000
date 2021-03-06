//
//  SdrView.swift
//  
//
//  Created by Douglas Adams on 4/21/22.
//

import SwiftUI
import ComposableArchitecture

import Api6000
import LoginView
import ClientView
import PickerView
import LogView
import Shared

// ----------------------------------------------------------------------------
// MARK: - View

public struct SdrView: View {
  let store: Store<SdrState, SdrAction>
  
  public init(store: Store<SdrState, SdrAction>) {
    self.store = store
  }
  
//  @AppStorage(wrappedValue: false, "leftSideView") var leftSideView: Bool
//  @AppStorage(wrappedValue: false, "rightSideView") var rightSideView: Bool
  @State var leftWidth: CGFloat = 75
  @State var rightWidth: CGFloat = 275
  @State var totalWidthMin: CGFloat = 500
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
    
      VStack {
        HStack(spacing: 0) {
          if viewStore.leftSideVisible {
            LeftSideView(
              store:
                Store(
                  initialState: LeftSideState(),
                  reducer: leftSideReducer,
                  environment: LeftSideEnvironment()
                )
            )
          }
          Divider()
          VSplitView {
            PanadapterContainerView()
            WaterfallContainerView()
          }
          .frame(minWidth: totalWidthMin,  maxWidth: .infinity, minHeight: 430)
          Divider()
          if viewStore.rightSideVisible {
            RightSideView(slice: Model.shared.activeSlice!)
//              store:
//                Store(
//                  initialState: RightSideState(),
//                  reducer: rightSideReducer,
//                  environment: RightSideEnvironment()
//                )
//            )
          }
        }
        BottomButtonsView()
      }
      .frame(minWidth: totalWidthMin, maxWidth: .infinity)
      
      .onAppear(perform: { viewStore.send(.onAppear) } )
            
      // alert dialogs
      .alert(
        self.store.scope(state: \.alert),
        dismiss: .alertDismissed
      )
      
      // Picker sheet
      .sheet(
        isPresented: viewStore.binding(
          get: { $0.pickerState != nil },
          send: SdrAction.pickerAction(.cancelButton)),
        content: {
          IfLetStore(
            store.scope(state: \.pickerState, action: SdrAction.pickerAction),
            then: PickerView.init(store:)
          )
        }
      )
      
      .toolbar {
        ToolbarItemGroup(placement: .navigation) {
          Button {
            viewStore.send(.sidebarLeftClicked)
          } label: {
            Image(systemName: "sidebar.left")
              .font(.system(size: 18, weight: .regular))
          }
          .keyboardShortcut("l", modifiers: [.control, .command])
          .disabled(!viewStore.isConnected)
        }
        
        ToolbarItemGroup(placement: .principal) {
          Button(viewStore.isConnected ? "Disconnect" : "Connect") { viewStore.send(.connectButton) }
            .keyboardShortcut(viewStore.model.radio == nil ? .defaultAction : .cancelAction)
          
          Button("Pan") {}
          Button("Tnf") {}
          Button("Marker") {}
          Button("Rcvd Audio") {}
          Button("Xmit Audio") {}
        }
        
        ToolbarItemGroup(placement: .principal) {
          Image(systemName: "speaker.wave.2.circle")
            .font(.system(size: 24, weight: .regular))
          Slider(value: .constant(50), in: 0...100, step: 1)
            .frame(width: 100)
          Image(systemName: "speaker.wave.2.circle")
            .font(.system(size: 24, weight: .regular))
          Slider(value: .constant(75), in: 0...100, step: 1)
            .frame(width: 100)
          Spacer()
          Button("Log View") { WindowChoice.log.open("Log View") }
          
          Button {
            viewStore.send(.sidebarRightClicked)
          } label: {
            Image(systemName: "sidebar.right")
              .font(.system(size: 18, weight: .regular))
          }
          .keyboardShortcut("r", modifiers: [.control, .command])
          .disabled(!viewStore.isConnected)
        }
      }
    }
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

public struct SdrView_Previews: PreviewProvider {
  public static var previews: some View {
    SdrView(
      store: Store(
        initialState: SdrState(),
        reducer: sdrReducer,
        environment: SdrEnvironment()
      )
    )
  }
}

