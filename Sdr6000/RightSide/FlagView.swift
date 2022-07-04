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
import Shared

// ----------------------------------------------------------------------------
// MARK: - Views

public struct FlagView: View {
  let store: Store<FlagState, FlagAction>
  
  public init(store: Store<FlagState, FlagAction>) {
    self.store = store
  }
  
  public var body: some View {
    
    WithViewStore(self.store) { viewStore in
      if viewStore.flagMinimized {
        // ----- Small size Flag -----
        FlagSmallView(store: store)
        
      } else {
        // ----- Full size Flag -----
        FlagLargeView(store: store)
      }
    }
  }
}

public struct FlagSmallView: View {
  let store: Store<FlagState, FlagAction>
  
  public init(store: Store<FlagState, FlagAction>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: 2) {
        HStack(spacing: 3) {
          Text("SPLIT").font(.title2)
          Text("TX").font(.title2)
          Text(viewStore.slice.sliceLetter ?? "--").font(.title2)
            .onTapGesture { viewStore.send(.sliceLetterClicked) }
        }
        TextField(
          "Frequency",
          text: viewStore.binding(get: \.slice.frequency.hzToMhz, send: { .frequencyChanged($0) })
        )
        .font(.title2)
        .multilineTextAlignment(.trailing)
      }
      .frame(width: 100)
    }
  }
}

public struct FlagLargeView: View {
  let store: Store<FlagState, FlagAction>
  
  public init(store: Store<FlagState, FlagAction>) {
    self.store = store
  }

  func filterWidth(_ slice: Slice) -> String {
    var formattedWidth = ""
    
    let width = slice.filterHigh - slice.filterLow
    switch width {
      
    case 1_000...:  formattedWidth = String(format: "%2.1fk", Float(width)/1000.0)
    case 0..<1_000: formattedWidth = String(format: "%3d", width)
    default:        formattedWidth = "0"
    }
    return formattedWidth
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack(spacing: 2) {
        HStack(spacing: 3) {
          Image(systemName: "x.circle").frame(width: 25, height: 25)
          Picker("", selection: viewStore.binding(get: \.slice.rxAnt , send: { .rxAntennaSelection($0) })) {
            ForEach(viewStore.slice.rxAntList, id: \.self) {
              Text($0).font(.system(size: 10))
            }
          }
          .labelsHidden()
          .pickerStyle(.menu)
          
          Picker("", selection: viewStore.binding(get: \.slice.txAnt , send: { .txAntennaSelection($0) })) {
            ForEach(viewStore.slice.txAntList, id: \.self) {
              Text($0).font(.system(size: 10))
            }
          }
          .labelsHidden()
          .pickerStyle(.menu)
          
          Text( filterWidth(viewStore.slice) )
          Text("SPLIT").font(.title2)
            .onTapGesture { viewStore.send(.splitClicked) }
            .foregroundColor(viewStore.slice.splitId == nil ? .gray : .yellow)
          
          Text("TX").font(.title2).foregroundColor(viewStore.slice.txEnabled ? .red : .gray)
          Text(viewStore.slice.sliceLetter ?? "--").font(.title2)
            .onTapGesture { viewStore.send(.sliceLetterClicked) }
        }
        .padding(.top, 10)
        
        HStack(spacing: 3) {
          Image(systemName: "lock").frame(width: 25, height: 25)
          
//          Group {
//            Toggle("NB", isOn: viewStore.binding(get: \.slice.nbEnabled, send: .nbClicked ))
//            Toggle("NR", isOn: viewStore.binding(get: \.slice..nrEnabled, send: .nrClicked ))
//            Toggle("ANF", isOn: viewStore.binding(get: \.slice..anfEnabled, send: .anfClicked ))
//            Toggle("QSK", isOn: viewStore.binding(get: \.slice..qskEnabled, send: .qskClicked ))
//          }
//          .font(.system(size: 10))
//          .toggleStyle(.button)
          
          TextField(
            "Frequency",
            text: viewStore.binding(get: \.slice.frequency.hzToMhz, send: { .frequencyChanged($0) } )
          )
          .font(.title2)
          .multilineTextAlignment(.trailing)
        }
        LevelIndicatorView(level: viewStore.sMeterValue, type: .sMeter)
        FlagButtonsView(store: store)
      }
      .frame(width: 275)
      .padding(.horizontal)
    }
  }
}

public struct FlagButtonsView: View {
  let store: Store<FlagState, FlagAction>
  
  public init(store: Store<FlagState, FlagAction>) {
    self.store = store
  }
  
  enum Buttons: String, CaseIterable {
    case aud = "AUD"
    case dsp = "DSP"
    case mode = "MODE"
    case xrit = "XRIT"
    case dax = "DAX"
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      
      VStack(alignment: .center) {
        
        Picker("", selection: viewStore.binding(get: \.subViewSelection, send: { .subViewSelectionChanged($0) } )) {
          ForEach(Buttons.allCases, id: \.self) {
            Text($0.rawValue)
          }
        }
        .labelsHidden()
        .pickerStyle(.segmented)
        
        switch viewStore.subViewSelection {
        case Buttons.aud.rawValue:    AudView(store: store)
        case Buttons.dsp.rawValue:    DspView()
        case Buttons.mode.rawValue:   ModeView()
        case Buttons.xrit.rawValue:   XritView()
        case Buttons.dax.rawValue:    DaxView()
        default:                      EmptyView()
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
        initialState: FlagState(slice: Slice(0)),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Buttons -----")
  }
}

struct FlagView_Previews: PreviewProvider {
  static var previews: some View {
    FlagView(
      store: Store(
        initialState: FlagState(slice: Slice(0)),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Flag -----")
    
    FlagView(
      store: Store(
        initialState: FlagState(slice: Slice(0), subViewSelection: "AUD"),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Flag w/AUD -----")
    
    FlagView(
      store: Store(
        initialState: FlagState(slice: Slice(0), subViewSelection: "DSP"),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Flag w/DSP -----")
    
    FlagView(
      store: Store(
        initialState: FlagState(slice: Slice(0), subViewSelection: "MODE"),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Flag w/MODE -----")
    
    FlagView(
      store: Store(
        initialState: FlagState(slice: Slice(0), subViewSelection: "XRIT"),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Flag w/XRIT -----")
    
    FlagView(
      store: Store(
        initialState: FlagState(slice: Slice(0), subViewSelection: "DAX"),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Flag w/DAX -----")
    
    FlagView(
      store: Store(
        initialState: FlagState(slice: Slice(0), flagMinimized: true),
        reducer: flagReducer,
        environment: FlagEnvironment()
      )
    )
    .previewDisplayName("----- Flag Minized -----")
  }
}
