//
//  InfoSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct InfoSettingsView: View {
  
  @State var applicationVersion = "4.1.16 (245)"
  @State var serialNumber = "1234-5678-9012-3456"
  @State var hardwareVersion = "10.1.2"
  @State var firmwareVersion = "3.2.24 (1325)"
  
  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      
      VStack(alignment: .leading, spacing: 40) {
        Text("Supporting Applications").font(.title2.bold()).foregroundColor(.blue)
        VStack(alignment: .leading, spacing: 15) {
          Text("Not implemented (coming soon)")
        }.frame(width: 200, alignment: .leading)
      }
      
      Spacer()
      
      VStack(alignment: .leading, spacing: 15) {
        Text("Versions").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 0) {
          VStack(alignment: .leading, spacing: 15) {
            Text("Sdr6000 Version")
            Text("Radio Serial Number")
            Text("Radio Hardware Version")
            Text("Radio Firmware Version")
          }.frame(width: 200, alignment: .leading)
          
          VStack(alignment: .leading, spacing: 15) {
            Text("v" + applicationVersion)
            Text(serialNumber)
            Text("v" + hardwareVersion)
            Text("v" + firmwareVersion)
          }
        }
      }
      Spacer()
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}

struct InfoSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    InfoSettingsView()
      .frame(width: 600, height: 400)
      .padding()
  }
}
