//
//  DisplayPopover.swift
//  Components/SdrViewer/SubViews/Popovers
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

struct DisplayPopover: View {
  
  let textWidth: CGFloat = 75
  @State var average: CGFloat = 25.0
  @State var framesPerSecond: CGFloat = 75.0
  @State var fill: CGFloat = 75.0
  @State var weightedAverage = false
  @State var colorGain: CGFloat = 75.0
  @State var duration: CGFloat = 75.0
  @State var autoBlackLevel: CGFloat = 75.0
  @State var autoBlack = false
  
  @State var colorGradients = ["Ant1", "Ant2", ]
  @State var selectedColorGradient = "Ant1"
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 20) {
          Text("Average").frame(width: textWidth, alignment: .leading)
          Text("\(String(format: "%.0f", average))")
          Slider(value: $average, in: 0...100).frame(width: 100)
        }
        HStack(spacing: 20) {
          Text("Frames/sec").frame(width: textWidth, alignment: .leading)
          Text("\(String(format: "%.0f", framesPerSecond))")
          Slider(value: $framesPerSecond, in: 0...100).frame(width: 100)
        }
        HStack(spacing: 20) {
          Text("Fill").frame(width: textWidth, alignment: .leading)
          Text("\(String(format: "%.0f", fill))")
          Slider(value: $fill, in: 0...100).frame(width: 100)
        }
        HStack(spacing: 20) {
          Text("Weighted Average").frame(width: 140, alignment: .leading)
          Toggle("", isOn: $weightedAverage)
        }
      }
      
      Divider().background(.blue)
      
      VStack(alignment: .leading, spacing: 0) {
        HStack(spacing: 20) {
          Text("Color Gradient").frame(width: 100, alignment: .leading)
          Picker("", selection: $selectedColorGradient) {
            ForEach(colorGradients, id: \.self) {
              Text($0)
            }
          }
          .pickerStyle(.menu)
          .frame(width: 100)
        }
        HStack(spacing: 20) {
          Text("Color Gain").frame(width: textWidth, alignment: .leading)
          Text("\(String(format: "%.0f", colorGain))")
          Slider(value: $colorGain, in: 0...100).frame(width: 100)
        }
        HStack(spacing: 0) {
          Text("Auto Black").frame(width: 70, alignment: .leading)
          Toggle("", isOn: $autoBlack).frame(width: 23)
          Text("\(String(format: "%.0f", autoBlackLevel))").frame(width: 20).padding(.trailing, 18)
          Slider(value: $autoBlackLevel, in: 0...100).frame(width: 100)
        }
        HStack(spacing: 20) {
          Text("Duration").frame(width: textWidth, alignment: .leading)
          Text("\(String(format: "%.0f", duration))")
          Slider(value: $duration, in: 0...100).frame(width: 100)
        }
      }
    }
    .frame(width:260)
    .padding(10)
  }
}

struct DisplayPopover_Previews: PreviewProvider {
  static var previews: some View {
    DisplayPopover()
  }
}
