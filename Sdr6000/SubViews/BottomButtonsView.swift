//
//  BottomButtonsView.swift
//  
//
//  Created by Douglas Adams on 4/21/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct BottomButtonsView: View {
  
  @AppStorage("stationName") var stationName: String?
  
  var body: some View {
    VStack(alignment: .leading) {
      Divider()
      HStack {
        Spacer()
        HStack {
          Text("MyRadio")
          Text("v3.2.5.1234").padding(.trailing, 40)
          Text("Station: MyStation")
        }
        .font(.system(size: 14, weight: .light, design: .monospaced))
        Spacer()
      }
    }
    .padding(.horizontal, 20)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct BottomButtonsView_Previews: PreviewProvider {
  static var previews: some View {
    BottomButtonsView()
  }
}
