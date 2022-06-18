//
//  ColorsSettingsView.swift
//  xMini6001
//
//  Created by Douglas Adams on 5/13/21.
//

import SwiftUI

struct ColorsSettingsView: View {
  
  @AppStorage("spectrum") var spectrum: Color = .white
  @AppStorage("spectrumFill") var spectrumFill: Color = .white.opacity(0.2)
  @AppStorage("frequencyLegend") var frequencyLegend: Color = .green
  @AppStorage("dbLegend") var dbLegend: Color = .green
  @AppStorage("gridLines") var gridLines: Color = .white.opacity(0.3)
  @AppStorage("dbLines") var dbLines: Color = .white.opacity(0.3)
  @AppStorage("markerEdge") var markerEdge: Color = .red.opacity(0.2)
  @AppStorage("markerSegment") var markerSegment: Color = .white.opacity(0.2)
  @AppStorage("sliceFilter") var sliceFilter: Color = .white.opacity(0.3)
  @AppStorage("marker") var marker: Color = .yellow
  @AppStorage("tnfActive") var tnfActive: Color = .green.opacity(0.2)
  @AppStorage("tnfInactive") var tnfInactive: Color = .yellow.opacity(0.2)
  @AppStorage("sliceActive") var sliceActive: Color = .red.opacity(0.6)
  @AppStorage("sliceInactive") var sliceInactive: Color = .yellow.opacity(0.6)
  @AppStorage("background") var background: Color = .black

  
  let colors: Dictionary<String,Color> =
  [
    "spectrum": .white,
    "spectrumFill": .white.opacity(0.2),
    "frequencyLegend": .green,
    "dbLegend": .green,
    "gridLines": .white.opacity(0.3),
    "dbLines": .white.opacity(0.3),
    "markerEdge": .red.opacity(0.2),
    "markerSegment": .white.opacity(0.2),
    "sliceFilter": .white.opacity(0.3),
    "marker": .yellow,
    "tnfActive": .green.opacity(0.2),
    "tnfInactive": .yellow.opacity(0.2),
    "sliceActive": .red.opacity(0.6),
    "sliceInactive": .yellow.opacity(0.6),
    "background": .black
  ]
 
  let columnSpacing: CGFloat = 100

  func resetAll() {
    spectrum = colors["spectrum"]!
    spectrumFill = colors["spectrumFill"]!
    frequencyLegend = colors["frequencyLegend"]!
    dbLegend = colors["dbLegend"]!
    gridLines = colors["gridLines"]!
    dbLines = colors["dbLines"]!
    markerEdge = colors["markerEdge"]!
    markerSegment = colors["markerSegment"]!
    sliceFilter = colors["sliceFilter"]!
    marker = colors["marker"]!
    tnfActive = colors["tnfActive"]!
    tnfInactive = colors["tnfInactive"]!
    sliceActive = colors["sliceActive"]!
    sliceInactive = colors["sliceInactive"]!
    background = colors["background"]!
  }
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 15) {
      Spacer()
      
      Group {
        HStack(spacing: columnSpacing) {
          HStack {
            Text("Spectrum").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $spectrum)
            Button("Reset") { spectrum = colors["spectrum"]! }
          }
          HStack {
            Text("Spectrum Fill").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $spectrumFill)
            Button("Reset") { spectrumFill = colors["spectrumFill"]! }
          }
        }
        
        HStack(spacing: columnSpacing) {
          HStack {
            Text("Freq Legend").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $frequencyLegend)
            Button("Reset") {}
          }
          HStack {
            Text("Db Legend").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $dbLegend)
            Button("Reset") {}
          }
        }
        
        HStack(spacing: columnSpacing) {
          HStack {
            Text("Grid lines").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $gridLines)
            Button("Reset") {}
          }
          HStack {
            HStack {
              Text("Db lines").frame(width: 90, alignment: .trailing)
              ColorPicker("", selection: $dbLines)
              Button("Reset") {}
            }
          }
        }
        
        HStack(spacing: columnSpacing) {
          HStack {
            Text("Marker edge").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $markerEdge)
            Button("Reset") {}
          }
          HStack {
            Text("Marker segment").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $markerSegment)
            Button("Reset") {}
          }
        }
        
        HStack(spacing: columnSpacing)  {
          HStack {
            Text("Slice filter").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $sliceFilter)
            Button("Reset") {}
          }
          HStack {
            Text("Marker").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $marker)
            Button("Reset") {}
          }
        }
      }
      
      Group {
        HStack(spacing: columnSpacing) {
          HStack {
            Text("Tnf (active)").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $tnfActive)
            Button("Reset") {}
          }
          HStack {
            Text("Tnf (Inactive)").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $tnfInactive)
            Button("Reset") {}
          }
        }
        
        HStack(spacing: columnSpacing) {
          HStack {
            Text("Slice (active)").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $sliceActive)
            Button("Reset") {}
          }
          HStack {
            Text("Slice (Inactive)").frame(width: 90, alignment: .trailing)
            ColorPicker("", selection: $sliceInactive)
            Button("Reset") {}
          }
        }
        
        HStack {
          Text("Background").frame(width: 90, alignment: .trailing)
          ColorPicker("", selection: $background)
          Button("Reset") {}
        }
        
        Spacer()
        HStack {
          Spacer()
          Button("Reset All") {}
        }
      }
    }
    .frame(width: 600, height: 400)
    .padding()
  }
}

struct ColorsSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    ColorsSettingsView()
      .frame(width: 600, height: 400)
      .padding()
  }
}

extension Color: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = Data(base64Encoded: rawValue) else {
            self = .pink
            return
        }
        
        do {
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSColor ?? .systemPink
            self = Color(color)
        } catch {
            self = .pink
        }
    }

    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: NSColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch {
            return ""
        }
    }
}
