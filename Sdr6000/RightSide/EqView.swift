//
//  SwiftUIView.swift
//  
//
//  Created by Douglas Adams on 4/27/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

public struct EqView: View {
  
  public init() {}

  @State var hz63: CGFloat = 1.0
  @State var hz125: CGFloat = 0.7
  @State var hz250: CGFloat = 0.3
  @State var hz500: CGFloat = 0.0
  @State var hz1000: CGFloat = -0.3
  @State var hz2000: CGFloat = -0.6
  @State var hz4000: CGFloat = -0.9
  @State var hz8000: CGFloat = -1.0
  
  @State var on = true
  @State var rx = true
  @State var tx = false
  
  public var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 8) {
        Text("63")
        Text("125")
        Text("250")
        Text("500")
        Text("1k")
        Text("2k")
        Text("4k")
        Text("8k")
      }
      .offset(x: 50, y: 0)

      HStack(spacing: 0) {
        VStack(spacing: 10) {
          Text("+10 Db")
          Spacer()
          Toggle("On", isOn: $on).toggleStyle(.button)
          Toggle("Rx", isOn: $rx).toggleStyle(.button)
          Toggle("Tx", isOn: $tx).toggleStyle(.button)
          Spacer()
          Text("-10 Db")
        }.frame(width: 50, height: 240)
        
        VStack(spacing: -5) {
          Slider(value: $hz63, in: -1...1, step: 0.2)
          Slider(value: $hz125, in: -1...1, step: 0.2)
          Slider(value: $hz250, in: -1...1, step: 0.2)
          Slider(value: $hz500, in: -1...1, step: 0.2)
          Slider(value: $hz1000, in: -1...1, step: 0.2)
          Slider(value: $hz2000, in: -1...1, step: 0.2)
          Slider(value: $hz4000, in: -1...1, step: 0.2)
          Slider(value: $hz8000, in: -1...1, step: 0.2)
        }
        .rotationEffect(.degrees(-90))
      }
      Divider().background(.blue)
    }
    .frame(width: 260, height: 280)
    .padding(.trailing, 10)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct EqView_Previews: PreviewProvider {
  static var previews: some View {
    EqView()
  }
}
