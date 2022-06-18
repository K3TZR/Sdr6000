//
//  RxSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct RxSettingsView: View {
  
  @State var calibrationFrequency = "15,000,000"
  @State var snapToTuneStep = false
  @State var singleClickToTune = false
  @State var startSlicesMinimized = false
  @State var muteLocalAudioWhenRemote = false
  @State var binauralAudio = true
  @State var calibrationOffset = "123"
  
  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      VStack(alignment: .leading) {
        Text("Frequency offset").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 50) {
          Text("Calibration frequency")
          TextField("", text: $calibrationFrequency)
            .frame(width: 100)
            .multilineTextAlignment(.trailing)
          Button("Calibrate") {}
        }
        HStack {
          Text("Offset (ppb)")
          TextField("", text: $calibrationOffset)
            .frame(width: 100)
            .multilineTextAlignment(.trailing)
        }
      }
      
      Spacer()
      
      VStack(alignment: .leading, spacing: 20) {
        Text("Tuning").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 100) {
          Toggle("Snap to tune step", isOn: $snapToTuneStep)
          Toggle("Single click to tune", isOn: $singleClickToTune)
            .disabled(true)
        }
        
        Text("Slices").font(.title2.bold()).foregroundColor(.blue)
        Toggle("Start slices minimized", isOn: $startSlicesMinimized)
          .disabled(true)
        
        Text("Audio").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 25) {
          Toggle("Mute local audio when remote", isOn: $muteLocalAudioWhenRemote)
          Toggle("Binaural audio", isOn: $binauralAudio)
        }
      }
      Spacer()
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}

struct RxSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    RxSettingsView()
      .frame(width: 600, height: 400)
      .padding()
  }
}
