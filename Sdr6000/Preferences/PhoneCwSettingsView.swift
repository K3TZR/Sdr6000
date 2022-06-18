//
//  PhoneCwSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct PhoneCwSettingsView: View {
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
  @State var iambicModes = ["A", "B"]
  @State var selectedIambicMode = "A"
  @State var selectedCwSideband = "Upper"
  @State var cwSidebands = ["Upper", "Lower"]
  @State var maxPower: Float = 76.0
  @State var hardwareAlc = false
  @State var txInWaterfall = false
  @State var rttyMarkDefault = ""
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Spacer()
      VStack(alignment: .leading, spacing: 10) {
        Text("Microphone").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 121) {
          Toggle("Microphone bias", isOn: $accTx)
          Toggle("Microphone level during receive", isOn: $accTx)
        }
        Toggle("+20 db Microphone gain", isOn: $accTx)
      }

      
      Spacer()
      
      VStack(alignment: .leading) {
        Text("CW").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 42) {
          HStack(spacing: 0) {
            Toggle("Iambic", isOn: $accTx).frame(width: 90, alignment: .leading)
            Picker("", selection: $selectedIambicMode) {
              ForEach(iambicModes, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(.segmented)
            .frame(width: 110)
          }
          Toggle("Swap dot / dash", isOn: $accTx)
        }
        HStack(spacing: 50) {
          HStack(spacing: 10) {
            Text("CW Sideband")
            Picker("", selection: $selectedCwSideband) {
              ForEach(cwSidebands, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(.segmented)
            .frame(width: 100)
          }
          Toggle("CWX sync", isOn: $hardwareAlc)
            .toggleStyle(.checkbox)
        }
      }

      Spacer()
      
      VStack(alignment: .leading) {
        Text("Digital").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 10) {
          Text("RTTY Mark default").frame(width: 115, alignment: .leading)
          TextField("", text: $rttyMarkDefault).frame(width: 100)
        }
      }

      Spacer()
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}

struct PhoneCwSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    PhoneCwSettingsView()
      .frame(width: 600, height: 400)
      .padding()
  }
}
