//
//  RightSideCore.swift
//  Sdr6000
//
//  Created by Douglas Adams on 6/19/22.
//

import ComposableArchitecture

// ----------------------------------------------------------------------------
// MARK: - Structs and Enums


// ----------------------------------------------------------------------------
// MARK: - State, Actions & Environment

public struct RightSideState: Equatable {
  public var rxIsOn: Bool
  public var txIsOn: Bool
  public var ph1IsOn: Bool
  public var ph2IsOn: Bool
  public var cwIsOn: Bool
  public var eqIsOn: Bool
  public var flagSubView: String
  public var flagMinimized: Bool

  public init
  (
    rxIsOn: Bool = false,
    txIsOn: Bool = false,
    ph1IsOn: Bool = false,
    ph2IsOn: Bool = false,
    cwIsOn: Bool = false,
    eqIsOn: Bool = false,
    flagSubView: String = "none",
    flagMinimized: Bool = false
  )
  {
    self.rxIsOn = rxIsOn
    self.txIsOn = txIsOn
    self.ph1IsOn = ph1IsOn
    self.ph2IsOn = ph2IsOn
    self.cwIsOn = cwIsOn
    self.eqIsOn = eqIsOn
    self.flagSubView = flagSubView
    self.flagMinimized = flagMinimized
  }
}

public enum RightSideAction: Equatable {
  
  // UI controls
  case toggle(WritableKeyPath<RightSideState, Bool>)
  case flagStateChanged(String)
  case sliceLetterClicked
}

public struct RightSideEnvironment {
  
  public init() {}
}

// ----------------------------------------------------------------------------
// MARK: - Reducer

public let rightSideReducer = Reducer<RightSideState, RightSideAction, RightSideEnvironment>
{ state, action, environment in
  
  switch action {
    
  case .toggle(let keyPath):
    // handles all buttons with a Bool state
    state[keyPath: keyPath].toggle()
    return .none
    
  case .flagStateChanged(let selection):
    if state.flagSubView == "none" {
      state.flagSubView = selection
    } else if state.flagSubView == selection {
      state.flagSubView = "none"
    } else {
      state.flagSubView = selection
    }
    return .none
    
  case .sliceLetterClicked:
    // ignored by RightSide
//    state.flagMinimized.toggle()
    return .none
  }
}
//  .debug("-----> RIGHTSIDEVIEW")
