//
//  FlagView.swift
//  Components/SdrViewer/SubViews/SideViews
//
//  Created by Douglas Adams on 4/3/21.
//  Copyright © 2020-2021 Douglas Adams. All rights reserved.
//

import SwiftUI

import LevelIndicatorView

public enum FlagState {
  case aud
  case dsp
  case mode
  case xrit
  case dax
  case none
}

// ----------------------------------------------------------------------------
// MARK: - Views

struct FlagView: View {
  @State var flagState: FlagState

  public init
  (
    flagState: FlagState
  )
  {
    self.flagState = flagState
  }
  @State var rxAntennas = ["Ant1", "Ant2", ]
  @State var selectedRxAntenna = "Ant1"
  @State var txAntennas = ["Ant1", "Ant2", ]
  @State var selectedTxAntenna = "Ant1"
  @State var frequency = 14_200_000
  @State var filterWidth = "2.7k"
  @State var sliceLetter = "A"
  
  @State var nb = false
  @State var nr = true
  @State var anf = false
  @State var qsk = true
  
  @State var sMeterValue: CGFloat = 10.0

  var body: some View {
    VStack(alignment: .leading, spacing: 2) {
      HStack(spacing: 3) {
        Image(systemName: "x.circle").frame(width: 25, height: 25)
        Picker("", selection: $selectedRxAntenna) {
          ForEach(rxAntennas, id: \.self) {
            Text($0).font(.system(size: 8))
          }
        }
        .labelsHidden()
        .pickerStyle(.menu)
        
        Picker("", selection: $selectedTxAntenna) {
          ForEach(txAntennas, id: \.self) {
            Text($0).font(.system(size: 8))
          }
        }
        .labelsHidden()
        
        Text(filterWidth)
        Text("SPLIT").font(.title2)
        Text("TX").font(.title2)
        Text(sliceLetter).font(.title2)
      }
      .padding(.top, 10)
      
      HStack(spacing: 3) {
        Image(systemName: "lock").frame(width: 25, height: 25)

        Group {
          Toggle("NB", isOn: $nb)
          Toggle("NR", isOn: $nr)
          Toggle("ANF", isOn: $anf)
          Toggle("QSK", isOn: $qsk)
        }
        .font(.system(size: 8))
        .toggleStyle(.button)

        TextField(
          "Frequency",
          value: $frequency,
          formatter: NumberFormatter()
        )
        .font(.title2)
        .multilineTextAlignment(.trailing)
      }
      LevelIndicatorView(level: sMeterValue, type: .sMeter)
      FlagButtonsView(flagState: flagState)
    }
  }
}

public struct FlagButtonsView: View {
  @State private var flagState: FlagState

  public init
  (
    flagState: FlagState
  )
  {
    self.flagState = flagState
  }
  
  func update(_ currentState: FlagState, _ button: FlagState) -> FlagState {
    if currentState == .none {
      return button
    } else if currentState == button {
      return .none
    } else {
      return button
    }
  }

  public var body: some View {
    VStack(alignment: .center) {
      HStack {
        Button(action: { flagState = update(flagState, .aud) }) { Text("AUD") }.background(Color(flagState == .aud ? .controlAccentColor : .controlBackgroundColor))
        Button(action: { flagState = update(flagState, .dsp) }) { Text("DSP") }.background(Color(flagState == .dsp ? .controlAccentColor : .controlBackgroundColor))
        Button(action: { flagState = update(flagState, .mode) }) { Text("MODE") }.background(Color(flagState == .mode ? .controlAccentColor : .controlBackgroundColor))
        Button(action: { flagState = update(flagState, .xrit) }) { Text("XRIT") }.background(Color(flagState == .xrit ? .controlAccentColor : .controlBackgroundColor))
        Button(action: { flagState = update(flagState, .dax) }) { Text("DAX") }.background(Color(flagState == .dax ? .controlAccentColor : .controlBackgroundColor))
      }
 
     switch flagState {
      case .aud:    AudView()
      case .dsp:    DspView()
      case .mode:   ModeView()
      case .xrit:   XritView()
      case .dax:    DaxView()
      case .none:   EmptyView()
     }
    }
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview(s)

struct FlagButtonsView_Previews: PreviewProvider {
  static var previews: some View {
    FlagButtonsView(flagState: .none)
      .frame(width: 275, height: 30)
      .padding(.horizontal, 10)
      .previewDisplayName("----- Buttons -----")
  }
}

struct FlagView_Previews: PreviewProvider {
  static var previews: some View {
    FlagView(flagState: .none)
      .frame(width: 275)
      .padding(.horizontal, 10)
      .previewDisplayName("----- Flag -----")

    FlagView(flagState: .aud)
      .frame(width: 275)
      .padding(.horizontal, 10)
      .previewDisplayName("----- Flag + AUD -----")

  FlagView(flagState: .dsp)
    .frame(width: 275)
    .padding(.horizontal, 10)
    .previewDisplayName("----- Flag + DSP -----")

    FlagView(flagState: .mode)
      .frame(width: 275)
      .padding(.horizontal, 10)
      .previewDisplayName("----- Flag + MODE -----")

    FlagView(flagState: .xrit)
      .frame(width: 275)
      .padding(.horizontal, 10)
      .previewDisplayName("----- Flag + XRIT -----")

    FlagView(flagState: .dax)
      .frame(width: 275)
      .padding(.horizontal, 10)
      .previewDisplayName("----- Flag + DAX -----")
  }
}
