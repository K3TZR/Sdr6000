//
//  FlagView.swift
//  Components/SdrViewer/SubViews/SideViews
//
//  Created by Douglas Adams on 4/3/21.
//  Copyright © 2020-2021 Douglas Adams. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

import LevelIndicatorView

//public enum FlagState {
//  case aud
//  case dsp
//  case mode
//  case xrit
//  case dax
//  case none
//}

// ----------------------------------------------------------------------------
// MARK: - Views

struct FlagView: View {
  let store: Store<RightSideState, RightSideAction>
  
  public init(store: Store<RightSideState, RightSideAction>) {
    self.store = store
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
    WithViewStore(self.store) { viewStore in
      
      if viewStore.flagMinimized {
        // Small size Flag
        VStack(spacing: 2) {
          HStack(spacing: 3) {
          Text("SPLIT").font(.title2)
          Text("TX").font(.title2)
          Text(sliceLetter).font(.title2)
            .onTapGesture { viewStore.send(.sliceLetterClicked) }
          }
          TextField(
            "Frequency",
            value: $frequency,
            formatter: NumberFormatter()
          )
          .font(.title2)
          .multilineTextAlignment(.trailing)
        }
        .frame(width: 100)

      } else {
        // Full size Flag
        VStack(spacing: 2) {
          HStack(spacing: 3) {
            Image(systemName: "x.circle").frame(width: 25, height: 25)
            Picker("", selection: $selectedRxAntenna) {
              ForEach(rxAntennas, id: \.self) {
                Text($0).font(.system(size: 10))
              }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            
            Picker("", selection: $selectedTxAntenna) {
              ForEach(txAntennas, id: \.self) {
                Text($0).font(.system(size: 10))
              }
            }
            .labelsHidden()
            
            Text(filterWidth)
            Text("SPLIT").font(.title2)
            Text("TX").font(.title2)
            Text(sliceLetter).font(.title2)
              .onTapGesture { viewStore.send(.sliceLetterClicked) }
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
            .font(.system(size: 10))
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
          FlagButtonsView(store: store)
        }
        .frame(width: 275)
        .padding(.horizontal)
      }
    }
  }
}

public struct FlagButtonsView: View {
  let store: Store<RightSideState, RightSideAction>
  
  public init(store: Store<RightSideState, RightSideAction>) {
    self.store = store
  }
  
  let choices = ["AUD", "DSP", "MODE", "XRIT", "DAX"]
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      
      VStack(alignment: .center) {
        
        Picker("", selection: viewStore.binding(get: \.flagSubView, send: { .flagStateChanged($0) } )) {
          ForEach(choices, id: \.self) {
            Text($0)
          }
        }
        .labelsHidden()
        .pickerStyle(.segmented)
        
        switch viewStore.flagSubView {
        case "AUD":    AudView()
        case "DSP":    DspView()
        case "MODE":   ModeView()
        case "XRIT":   XritView()
        case "DAX":    DaxView()
        case "NONE":   EmptyView()
        default:       EmptyView()
        }
      }
    }
    .frame(width: 275)
    .padding(.horizontal)
  }
}

// ----------------------------------------------------------------------------
// MARK: - Preview(s)

struct FlagButtonsView_Previews: PreviewProvider {
  static var previews: some View {
    FlagButtonsView(
      store: Store(
        initialState: RightSideState(),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )
    .previewDisplayName("----- Buttons -----")
  }
}

struct FlagView_Previews: PreviewProvider {
  static var previews: some View {
    FlagView(
      store: Store(
        initialState: RightSideState(),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )
    .previewDisplayName("----- Flag -----")

    FlagView(
      store: Store(
        initialState: RightSideState(flagMinimized: true),
        reducer: rightSideReducer,
        environment: RightSideEnvironment()
      )
    )
    .previewDisplayName("----- Flag Minized -----")
  }
}
