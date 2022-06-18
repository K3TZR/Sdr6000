//
//  RadioSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct RadioSettingsView: View {
  @State var serialNumber = "1234-5678-9012-3456"
  @State var hardwareVersion = "10.1.2"
  @State var firmwareVersion = "3.2.24 (1325)"
  @State var options = ""
  @State var remoteOn = false
  @State var flexControl = false
  @State var selectedRegion = "USA"
  @State var selectedScreensaver = "Callsign"
  @State var model = "Flex-6500"
  @State var callsign = "K3TZR"
  @State var nickName = "Doug's Flex"

  private var regions = ["USA", "Other"]
  private var screensavers = ["Model", "Callsign", "Nickname"]

  var body: some View {
    
    VStack(alignment: .leading, spacing: 15) {
      HStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 15) {
          Text("Serial Number")
          Text("Hardware Version")
          Text("Firmware Version")
          Text("Options")
        }.frame(width: 130, alignment: .leading)
        
        VStack(alignment: .leading, spacing: 15) {
          Text(serialNumber)
          Text("v" + hardwareVersion)
          Text("v" + firmwareVersion)
          Text(options)
        }
      }
      HStack(spacing: 0) {
        Text("Remote On").frame(width: 130, alignment: .leading)
        Toggle("", isOn: $remoteOn)
      }

      HStack(spacing: 0) {
        Text("Flex Control").frame(width: 130, alignment: .leading)
        Toggle("", isOn: $flexControl)
      }
      
      HStack(spacing: 0) {
        Text("Region").frame(width: 120, alignment: .leading)
        Picker("", selection: $selectedRegion) {
          ForEach(regions, id: \.self) {
            Text($0)
          }
        }
        .disabled(true)
        .pickerStyle(.segmented)
        .frame(width: 100)
      }
      HStack(spacing: 0) {
        Text("Screen saver").frame(width: 120, alignment: .leading)
        Picker("", selection: $selectedScreensaver) {
          ForEach(screensavers, id: \.self) {
            Text($0)
          }
        }
        .pickerStyle(.segmented)
        .frame(width: 200)
      }
      
      VStack(alignment: .leading) {
        HStack(spacing: 10) {
          Text("Model").frame(width: 120, alignment: .leading)
          Text(model)
        }
        HStack(spacing: 10) {
          Text("Nickname").frame(width: 115, alignment: .leading)
          TextField("Nickname", text: $nickName)
        }
        HStack(spacing: 10) {
          Text("Callsign").frame(width: 115, alignment: .leading)
          TextField("Callsign", text: $callsign)
        }
      }.frame(width: 250, alignment: .leading)
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}

struct RadioSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RadioSettingsView()
        .frame(width: 600, height: 400)
        .padding()
    }
}
