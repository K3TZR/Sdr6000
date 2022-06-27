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

struct RightSideView: View {
  let store: Store<RightSideState, RightSideAction>
  
  public init(store: Store<RightSideState, RightSideAction>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      
      VStack(alignment: .center) {
        HStack {
          Group {
            Toggle("Rx", isOn: viewStore.binding(get: \.rxIsOn, send: .toggle(\.rxIsOn)))
            Toggle("Tx", isOn: viewStore.binding(get: \.txIsOn, send: .toggle(\.txIsOn)))
            Toggle("Ph1", isOn: viewStore.binding(get: \.ph1IsOn, send: .toggle(\.ph1IsOn)))
            Toggle("Ph2", isOn: viewStore.binding(get: \.ph2IsOn, send: .toggle(\.ph2IsOn)))
            Toggle("Cw", isOn: viewStore.binding(get: \.cwIsOn, send: .toggle(\.cwIsOn)))
            Toggle("Eq", isOn: viewStore.binding(get: \.eqIsOn, send: .toggle(\.eqIsOn)))
          }
          .toggleStyle(.button)
//          .disabled(viewStore.model.radio!.activeSlice == nil || viewStore.model.radio!.activePanadapter == nil )
        }
        Divider()
        ScrollView {
          VStack {
            if viewStore.rxIsOn {
              FlagView(
                store:
                  Store(initialState: FlagState(slice: viewStore.slice),
                        reducer: flagReducer,
                        environment: FlagEnvironment()
                       )
              )
            }
            if viewStore.txIsOn { TxView() }
            if viewStore.ph1IsOn { Ph1View() }
            if viewStore.ph2IsOn { Ph2View() }
            if viewStore.cwIsOn { CwView() }
            if viewStore.eqIsOn { EqView() }
          }
        }
      }
    }
    .frame(width: 275)
    .padding(.horizontal)
  }
}


// ----------------------------------------------------------------------------
// MARK: - Preview

struct SideView_Previews: PreviewProvider {
  static var previews: some View {
    RightSideView(
      store: Store(
        initialState: RightSideState(slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )

    RightSideView(
      store: Store(
        initialState: RightSideState(rxIsOn: true, slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )

    RightSideView(
      store: Store(
        initialState: RightSideState(txIsOn: true, slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )

    RightSideView(
      store: Store(
        initialState: RightSideState(ph1IsOn: true, slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )

    RightSideView(
      store: Store(
        initialState: RightSideState(ph2IsOn: true, slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )

    RightSideView(
      store: Store(
        initialState: RightSideState(cwIsOn: true, slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )

    RightSideView(
      store: Store(
        initialState: RightSideState(eqIsOn: true, slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )

    RightSideView(
      store: Store(
        initialState: RightSideState(rxIsOn: true, txIsOn: true, ph1IsOn: true, ph2IsOn: true, cwIsOn: true, eqIsOn: true, slice: Slice(0)),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )
  }
}
