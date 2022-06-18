//
//  AntPopover.swift
//  Components/SdrViewer/SubViews/Popovers
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

struct AntPopover: View {
  
  @State var rxAntennas = ["Ant1", "Ant2", ]
  @State var selectedRxAntenna = "Ant1"
  @State var rfGain: CGFloat = 25.0
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Text("RX Ant")
        Picker("", selection: $selectedRxAntenna) {
          ForEach(rxAntennas, id: \.self) {
            Text($0)
          }
        }
        .pickerStyle(.menu)
        .frame(width: 100)
      }
      Button("Loop A") {}
      HStack(spacing: 10) {
        Text("RF Gain")
        Slider(value: $rfGain, in: 0...100).frame(width: 100)
        Text("\(String(format: "%.0f", rfGain))").frame(width: 50)
      }
    }
    .frame(width: 250, height: 150)
    .padding()
  }
}

struct AntPopover_Previews: PreviewProvider {
    static var previews: some View {
      AntPopover()
    }
}
