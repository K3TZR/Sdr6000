//
//  RightSideView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI
import ComposableArchitecture

import Api6000
import Shared

// ----------------------------------------------------------------------------
// MARK: - View

struct RightSideView: View , Equatable {
  @ObservedObject var slice: Slice
//  let store: Store<RightSideState, RightSideAction>
//
//  public init(store: Store<RightSideState, RightSideAction>) {
//    self.store = store
//  }
  
  static func == (lhs: RightSideView, rhs: RightSideView) -> Bool {
    true
  }
  
  @AppStorage("rxIsOn") var rxIsOn = false
  @AppStorage("txIsOn") var txIsOn = false
  @AppStorage("ph1IsOn") var ph1IsOn = false
  @AppStorage("ph2IsOn") var ph2IsOn = false
  @AppStorage("cwIsOn") var cwIsOn = false
  @AppStorage("eqIsOn") var eqIsOn = false

  var body: some View {
    
    let _ = Self._printChanges()
    
    VStack(alignment: .center) {
      HStack {
        Group {
          Toggle("Rx", isOn: $rxIsOn).keyboardShortcut("1", modifiers: [.control, .command])
          Toggle("Tx", isOn: $txIsOn).keyboardShortcut("2", modifiers: [.control, .command])
          Toggle("Ph1", isOn: $ph1IsOn).keyboardShortcut("3", modifiers: [.control, .command])
          Toggle("Ph2", isOn: $ph2IsOn).keyboardShortcut("4", modifiers: [.control, .command])
          Toggle("Cw", isOn: $cwIsOn).keyboardShortcut("5", modifiers: [.control, .command])
          Toggle("Eq", isOn: $eqIsOn).keyboardShortcut("6", modifiers: [.control, .command])
        }
        .toggleStyle(.button)
      }
      Divider()
      //      ScrollView {
      //        VStack {
      //          if slice != nil {
      //            if rxIsOn {
      //      Text("Flag goes here")
      VStack {
        FlagView()
      }
      //            if txIsOn { TxView() }
      //            if ph1IsOn { Ph1View() }
      //            if ph2IsOn { Ph2View() }
      //            if cwIsOn { CwView() }
      //            if eqIsOn { EqView() }
      //          }
    }
    //      }
    //    }
    .frame(width: 275)
    .padding(.horizontal)
  }
}


// ----------------------------------------------------------------------------
// MARK: - Preview

//struct SideView_Previews: PreviewProvider {
//  static var previews: some View {
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//
//    RightSideView(
//      store: Store(
//        initialState: RightSideState(),
//        reducer: rightSideReducer,
//        environment: RightSideEnvironment()
//      )
//    )
//  }
//}
