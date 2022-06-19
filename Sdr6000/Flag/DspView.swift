//
//  SwiftUIView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

struct DspView: View {
  
  @State private var level1 = 50.0
  @State private var level2 = 50.0
  @State private var level3 = 50.0
  @State private var level4 = 50.0
  
  @State private var wnb = false
  @State private var nb = true
  @State private var nr = false
  @State private var anf = true

  var body: some View {
    HStack(spacing: 20) {
      VStack(spacing: 5) {
        Toggle("WNB", isOn: $wnb)
        Toggle("NB", isOn: $nb)
        Toggle("NR", isOn: $nr)
        Toggle("ANF", isOn: $anf)
      }.toggleStyle(.button)
      
      VStack(spacing: -5) {
        Slider(value: $level1, in: 0...100)
        Slider(value: $level2, in: 0...100)
        Slider(value: $level3, in: 0...100)
        Slider(value: $level4, in: 0...100)
      }
      
      VStack(spacing: 12) {
        Text(String(format: "%2.0f",level1)).frame(width: 30)
        Text(String(format: "%2.0f",level2)).frame(width: 30)
        Text(String(format: "%2.0f",level3)).frame(width: 30)
        Text(String(format: "%2.0f",level4)).frame(width: 30)
      }
    }
    .frame(width: 275, height: 110)
    .padding(.horizontal)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct DspView_Previews: PreviewProvider {
    static var previews: some View {
      DspView()
    }
}
