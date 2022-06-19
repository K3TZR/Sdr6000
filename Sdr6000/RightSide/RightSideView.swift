//
//  SideView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI
import ComposableArchitecture

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
        }
        Divider()
        ScrollView {
          VStack {
            if viewStore.rxIsOn { FlagView(store: store) }
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
        initialState: RightSideState(),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )
  }
}
