//
//  OtherSettingsView.swift
//  Sdr6000
//
//  Created by Douglas Adams on 6/17/22.
//

import SwiftUI


struct OtherSettingsView: View {

  @AppStorage("connectionType") var selectedConnectionType: String = "Local"
  @AppStorage("forceSmartlinkLogin") var forceSmartlinkLogin: Bool = false
  @AppStorage("useDefault") var useDefault: Bool = false

  private var connectionTypes = ["Local", "SmartLink", "Both"]

  var body: some View {
      VStack(alignment: .leading) {
        Spacer()
        VStack(alignment: .leading) {
          Text("Connection Mode").font(.title2.bold()).foregroundColor(.blue)
          Picker("", selection: $selectedConnectionType) {
            ForEach(["Local", "SmartLink", "Both"], id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.segmented)
          .frame(width: 200)
        }
        Spacer()
        VStack {
          Text("SmartLink Login").font(.title2.bold()).foregroundColor(.blue)
          Toggle("Force Smartlink Login", isOn: $forceSmartlinkLogin)
        }
        
        Spacer()
        VStack {
          Text("Default").font(.title2.bold()).foregroundColor(.blue)
          Toggle("Use Default", isOn: $useDefault)
        }
        Spacer()
      }
        .frame(width: 600, height: 400)
        .padding()
    }
}

struct OtherSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherSettingsView()
        .frame(width: 600, height: 400)
        .padding()
    }
}
