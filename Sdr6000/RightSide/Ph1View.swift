//
//  Ph1View.swift
//  
//
//  Created by Douglas Adams on 4/29/22.
//

import SwiftUI

import LevelIndicatorView

// ----------------------------------------------------------------------------
// MARK: -View


public struct Ph1View: View {
  
  public init() {}

  @State var micValue: CGFloat = -20.0
  @State var compressionValue: CGFloat = -15.0
  @State var selectedMicProfile = "Profile 1"
  @State var micProfiles = ["Profile 1", "Profile 2", "Profile 3"]
  @State var selectedMicSource = "Mic"
  @State var micSources = ["Mic", "Mac", "Dax"]
  @State var micSetting: CGFloat = -20.0
  @State var compressionSetting: CGFloat = -20.0
  @State var monSetting: CGFloat = -20.0
  
  @State var acc = true
  @State var dax = false
  @State var proc = false
  @State var mon = false

  public var body: some View {
    VStack {
      VStack(alignment: .leading, spacing: 5)  {
        LevelIndicatorView(level: micValue, type: .micLevel)
        LevelIndicatorView(level: compressionValue, type: .compression)
        //      Spacer()
      }
      
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          Picker("", selection: $selectedMicProfile) {
            ForEach(micProfiles, id: \.self) {
              Text($0)
            }
          }
          .labelsHidden()
          .pickerStyle(.menu)
          .frame(width: 190, alignment: .leading)
          Button(action: {}) { Text("Del").frame(width: 20) }
        }
        
        HStack {
          Picker("", selection: $selectedMicSource) {
            ForEach(micSources, id: \.self) {
              Text($0)
            }
          }
          .labelsHidden()
          .pickerStyle(.menu)
          .frame(width: 65, alignment: .leading)
          Slider(value: $micSetting, in: -1...1).frame(width: 110)
          Toggle("ACC", isOn: $acc).toggleStyle(.button).frame(width: 60)
        }
        
        HStack(spacing: 20) {
          Text("NOR")
          Text("DX")
          Text("DX+")
        }.padding(.leading, 80)
        
        HStack {
          Toggle("Proc", isOn: $proc).toggleStyle(.button).frame(width: 60)
          Slider(value: $compressionSetting, in: -1...1).frame(width: 110)
          Toggle("DAX", isOn: $dax).toggleStyle(.button).frame(width: 60)
        }
        
        HStack {
          Toggle("Mon", isOn: $mon).toggleStyle(.button).frame(width: 60)

          Slider(value: $monSetting, in: -1...1).frame(width: 160)
        }
      }
      Divider().background(.blue)
    }
    .frame(height: 210)
    .padding(.horizontal, 10)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct Ph1View_Previews: PreviewProvider {
  static var previews: some View {
    Ph1View()
      .frame(width: 260)
  }
}
