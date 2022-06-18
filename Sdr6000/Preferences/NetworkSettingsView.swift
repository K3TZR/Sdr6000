//
//  NetworkSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct NetworkSettingsView: View {
  
  @State var ipAddress = "192.168.1.200"
  @State var mask = "255.255.255.0"
  @State var macAddress = "aa:03:b8:9f:1c:e4"
  @State var gateway = "192.168.1.1"
  @State var privateIP = false
  @State var selectedAddressType = "DHCP"
  @State var selectedScreensaver = "Callsign"
  @State var model = "Flex-6500"
  @State var callsign = "K3TZR"
  @State var nickName = "Doug's Flex"

  private var addressTypes = ["Static", "DHCP"]
  private var screensavers = ["Model", "Callsign", "Nickname"]

  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      VStack(alignment: .leading, spacing: 10) {
        Text("Current Address").font(.title2.bold()).foregroundColor(.blue)
        HStack(spacing: 0) {
          VStack(alignment: .leading, spacing: 10) {
            Text("IP Address")
            Text("Mask")
            Text("MAC Address")
          }.frame(width: 120, alignment: .leading)
          
          VStack(alignment: .leading, spacing: 10) {
            Text(ipAddress)
            Text(mask)
            Text(macAddress)
          }
        }
      }
      
      HStack(spacing: 0) {
        Text("Address Type").frame(width: 110, alignment: .leading)
        Picker("", selection: $selectedAddressType) {
          ForEach(addressTypes, id: \.self) {
            Text($0)
          }
        }
        .pickerStyle(.segmented)
        .frame(width: 150)
      }
      HStack(spacing: 0) {
        Text("Enforce Private IP").frame(width: 120, alignment: .leading)
        Toggle("", isOn: $privateIP)
      }
      
      Spacer()
      HStack (spacing: 80) {
        Text("Static Address").font(.title2.bold()).foregroundColor(.blue)
        Button("Apply") {}
      }
      HStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 10) {
          Text("IP Address")
          Text("Mask")
          Text("Gateway")
        }.frame(width: 120, alignment: .leading)
        
        VStack(alignment: .leading, spacing: 10) {
          TextField("IP Address", text: $ipAddress)
          TextField("Mask", text: $mask)
          TextField("Gateway", text: $gateway)
        }.frame(width: 200, alignment: .leading)
      }
      
      Spacer()
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}

struct NetworkSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkSettingsView()
        .frame(width: 600, height: 400)
        .padding()
    }
}
