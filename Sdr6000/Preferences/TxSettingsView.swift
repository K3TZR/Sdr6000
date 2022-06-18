//
//  TxSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct TxSettingsView: View {
  
  @State var accTx: Bool = false
  @State var rcaTx1: Bool = false
  @State var rcaTx2: Bool = false
  @State var rcaTx3: Bool = false
  @State var txDelay: String = ""
  @State var timeout: String = ""
  @State var accTxDelay: String = ""
  @State var rcaTx1Delay: String = ""
  @State var rcaTx2Delay: String = ""
  @State var rcaTx3Delay: String = ""
  @State var txProfiles = ["abc", "cde", "fgh", "ijk"]
  @State var selectedTxProfile = "fgh"
  @State var txInhibit = false
  @State var interlockLevels = ["Disabled", "Active High", "Active Low"]
  @State var selectedAccessoryInterlockLevel = "Disabled"
  @State var selectedRcaInterlockLevel = "Disabled"
  @State var maxPower: Float = 76.0
  @State var hardwareAlc = false
  @State var txInWaterfall = false
  
  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      VStack(alignment: .leading, spacing: 10) {
        Text("Timings").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 50) {
          Toggle("ACC TX", isOn: $accTx).frame(width: 80, alignment: .leading)
          TextField("", text: $accTxDelay).frame(width: 100)
          Text("TX Delay").frame(width: 100, alignment: .leading)
          TextField("", text: $txDelay).frame(width: 100)
        }
        HStack(spacing: 50) {
          Toggle("RCA TX1", isOn: $rcaTx1).frame(width: 80, alignment: .leading)
          TextField("", text: $rcaTx1Delay).frame(width: 100)
          Text("Timeout (min)").frame(width: 100, alignment: .leading)
          TextField("", text: $txDelay).frame(width: 100)
        }
        HStack(spacing: 50) {
          Toggle("RCA TX2", isOn: $rcaTx2).frame(width: 80, alignment: .leading)
          TextField("", text: $rcaTx2Delay).frame(width: 100)
          Picker("Tx Profile", selection: $selectedTxProfile) {
            ForEach(txProfiles, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.menu)
          .frame(width: 220)
        }
        HStack(spacing: 50) {
          Toggle("RCA TX3", isOn: $rcaTx3).frame(width: 80, alignment: .leading)
          TextField("", text: $rcaTx3Delay).frame(width: 100)
          Toggle("TX Inhibit", isOn: $txInhibit)
            .toggleStyle(.checkbox)
        }
      }
      
      Spacer()
      
      VStack(alignment: .leading) {
        Text("Interlocks").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 50) {
          Text("RCA")
          Picker("", selection: $selectedRcaInterlockLevel) {
            ForEach(interlockLevels, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.menu)
          .frame(width: 150)
          Text("Accessory")
          Picker("", selection: $selectedAccessoryInterlockLevel) {
            ForEach(interlockLevels, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.menu)
          .frame(width: 150)
        }
      }
      
      Spacer()
      
      VStack(alignment: .leading) {
        Text("Power").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 70) {
          Text("Max Power")
          Text("\(String(format: "%.0f", maxPower))")
          Slider(value: $maxPower, in: 0...100).frame(width: 150)
          Toggle("Hardware ALC", isOn: $hardwareAlc)
            .toggleStyle(.checkbox)
        }
        
        Toggle("TX in Waterfall", isOn: $txInWaterfall)
          .toggleStyle(.checkbox)
        
      }
      
      Spacer()
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}


struct TxSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    TxSettingsView()
      .frame(width: 600, height: 400)
      .padding()
  }
}
