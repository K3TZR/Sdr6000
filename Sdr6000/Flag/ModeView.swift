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
    
    let buttonWidth: CGFloat = 50
    
    VStack {
      HStack{
        Picker("", selection: $selectedMode) {
          ForEach(mode, id: \.self) {
            Text($0)
          }
        }
        .labelsHidden()
        Button(action: {}) {Text("USB")}
        Button(action: {}) {Text("LSB")}
        Button(action: {}) {Text("CW")}
      }
      HStack {
        Group {
          Button(action: {}) {Text("1.0k")}
          Button(action: {}) {Text("1.2k")}
          Button(action: {}) {Text("1.4k")}
          Button(action: {}) {Text("1.6k")}
          Button(action: {}) {Text("1.8k")}
        }
        .frame(width: buttonWidth)
      }
      HStack {
        Group {
          Button(action: {}) {Text("2.0k")}
          Button(action: {}) {Text("2.2k")}
          Button(action: {}) {Text("2.4k")}
          Button(action: {}) {Text("2.6k")}
          Button(action: {}) {Text("2.8k")}
        }
        .frame(width: buttonWidth)
      }
    }
    .frame(width: 275, height: 110)
    .padding(.horizontal)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct ModeView_Previews: PreviewProvider {
    static var previews: some View {
      ModeView()
    }
}
