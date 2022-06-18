//
//  SideView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct RightSideView: View {
  let choices = ["Rx", "Tx", "P/Cw", "Phne", "Eq"]
  
  @State var showRx: Bool
  @State var showTx: Bool
  @State var showPh1: Bool
  @State var showPh2: Bool
  @State var showCw: Bool
  @State var showEq: Bool
  
  @State var isCwMode = true
  
  let width: CGFloat = 275
  let height: CGFloat = 240
  
  var body: some View {
    VStack(alignment: .center) {
      
      HStack {
        Group {
          Toggle("Rx", isOn: $showRx)
          Toggle("Tx", isOn: $showTx)
          Toggle("Ph1", isOn: $showPh1)
          Toggle("Ph2", isOn: $showPh2)
          Toggle("Cw", isOn: $showCw)
          Toggle("Eq", isOn: $showEq)
        }
        .toggleStyle(.button)
      }
      Divider()
      ScrollView([.vertical]) {
        if showRx { FlagView(flagState: .none) }
        if showTx { TxView() }
        if showPh1 { Ph1View() }
        if showPh2 { Ph2View() }
        if showCw { CwView() }
        if showEq { EqView() }
      }
    }
    //        .padding()
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct SideView_Previews: PreviewProvider {
  static var previews: some View {
    RightSideView(showRx: true,
                  showTx: false,
                  showPh1: false,
                  showPh2: false,
                  showCw: false,
                  showEq: false)
      .frame(width: 260)
  }
}
