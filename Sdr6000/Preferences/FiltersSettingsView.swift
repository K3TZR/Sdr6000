//
//  FiltersSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct FiltersSettingsView: View {

  @State var voiceLevel: Float = 50
  @State var cwLevel: Float = 25
  @State var digitalLevel: Float = 75

  @State var voiceAuto = false
  @State var cwAuto = false
  @State var digitalAuto = false
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Spacer()

      Text("Low Latency <------------------------> High Latency").frame(width: 450, alignment: .center)
      HStack(spacing: 40) {
        Text("Voice").frame(width: 40, alignment: .leading)
        Slider(value: $voiceLevel, in: 0...100).frame(width: 300)
        Toggle(isOn: $voiceAuto, label: { Text("Auto") })
      }
      HStack(spacing: 40) {
        Text("CW").frame(width: 40, alignment: .leading)
        Slider(value: $cwLevel, in: 0...100).frame(width: 300)
        Toggle(isOn: $cwAuto, label: { Text("Auto") })
      }
      HStack(spacing: 40) {
        Text("Digital").frame(width: 40, alignment: .leading)
        Slider(value: $digitalLevel, in: 0...100).frame(width: 300)
        Toggle(isOn: $digitalAuto, label: { Text("Auto") })
      }
      Spacer()
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}

struct FiltersSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersSettingsView()
        .frame(width: 600, height: 400)
        .padding()
    }
}
