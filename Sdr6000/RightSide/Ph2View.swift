//
//  Ph2View.swift
//  
//
//  Created by Douglas Adams on 4/28/22.
//

import SwiftUI

// ----------------------------------------------------------------------------
// MARK: - View

public struct Ph2View: View {

  public init() {}

  @State var amCarrier: CGFloat = 1.0
  @State var voxLevel: CGFloat = 0.7
  @State var voxDelay: CGFloat = 0.3
  @State var compressionLevel: CGFloat = 0.0
  @State var txFilterLow = "100"
  @State var txFilterHigh = "2,500"

  @State var vox = false
  @State var dexp = true

  public var body: some View {
    VStack(alignment: .leading) {

      HStack(spacing: 0)  {
        VStack(alignment: .center, spacing: 10) {
          Text("AM Carrier")
          Toggle("VOX", isOn: $vox).toggleStyle(.button).frame(width: 70)
          Text("Vox Delay")
          Toggle("DEXP", isOn: $dexp).toggleStyle(.button).frame(width: 70)
        }.frame(width: 75)
        
        VStack(spacing: -5) {
          Slider(value: $amCarrier, in: -1...1, step: 0.2)
          Slider(value: $voxLevel, in: -1...1, step: 0.2)
          Slider(value: $voxDelay, in: -1...1, step: 0.2)
          Slider(value: $compressionLevel, in: -1...1, step: 0.2)
          HStack {
            TextField("", text: $txFilterLow)
            TextField("", text: $txFilterHigh)
          }
        }
      }
      VStack(alignment: .leading) {
        HStack(spacing: 15) {
          Image(systemName: "b.circle").frame(width: 15, height: 15)
          Image(systemName: "m.circle").frame(width: 15, height: 15)
          Image(systemName: "plus.circle").frame(width: 15, height: 15)
          Text("Low Cut")
          Text("High Cut")
        }
      }
      Divider().background(.blue)
    }
    .frame(height: 160)
    .padding(.horizontal, 10)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview

struct Ph2View_Previews: PreviewProvider {
    static var previews: some View {
      Ph2View()
        .frame(width: 260)
    }
}
