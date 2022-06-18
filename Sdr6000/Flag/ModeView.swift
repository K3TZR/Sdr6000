//
//  ModeView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct ModeView: View {
  
  @State private var selectedMode = "USB"
  @State private var mode = [
    "LSB",
    "USB",
    "CW",
    "AM",
    "SAM",
    "DIGL",
    "DIGU",
    "FM",
    "DFM",
    "NFM",
    "RTTY"
  ]
  
  var body: some View {
    
    let buttonWidth: CGFloat = 27
    
    VStack {
      HStack{
        Picker("", selection: $selectedMode) {
          ForEach(mode, id: \.self) {
            Text($0)
          }
        }.frame(width: 75).padding(.trailing, 20)
        Button(action: {}) {Text("USB").frame(width: buttonWidth)}
        Button(action: {}) {Text("LSB").frame(width: buttonWidth)}
        Button(action: {}) {Text("CW").frame(width: buttonWidth)}
      }
      HStack {
        Button(action: {}) {Text("1.0k").frame(width: buttonWidth)}
        Button(action: {}) {Text("1.2k").frame(width: buttonWidth)}
        Button(action: {}) {Text("1.4k").frame(width: buttonWidth)}
        Button(action: {}) {Text("1.6k").frame(width: buttonWidth)}
        Button(action: {}) {Text("1.8k").frame(width: buttonWidth)}
      }
      HStack {
        Button(action: {}) {Text("2.0k").frame(width: buttonWidth)}
        Button(action: {}) {Text("2.2k").frame(width: buttonWidth)}
        Button(action: {}) {Text("2.4k").frame(width: buttonWidth)}
        Button(action: {}) {Text("2.6k").frame(width: buttonWidth)}
        Button(action: {}) {Text("2.8k").frame(width: buttonWidth)}
      }
    }
    .frame(height: 110)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct ModeView_Previews: PreviewProvider {
    static var previews: some View {
      ModeView()
        .frame(width: 275)
        .padding(.horizontal)
    }
}
