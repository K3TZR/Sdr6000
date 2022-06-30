//
//  LeftSideCore.swift
//  Sdr6000
//
//  Created by Douglas Adams on 6/29/22.
//

import ComposableArchitecture

import Api6000
import Shared

// ----------------------------------------------------------------------------
// MARK: - Structs and Enums


// ----------------------------------------------------------------------------
// MARK: - State, Actions & Environment

public struct LeftSideState: Equatable {
  public var forceUpdate = false
  public var showBands: Bool
  
  public init
  (
    showBands: Bool = false
  )
  {
    self.showBands = showBands
  }
}

public enum LeftSideAction: Equatable {
  
  case noAction
}

public struct LeftSideEnvironment {
  
  public init() {}
}

// ----------------------------------------------------------------------------
// MARK: - Reducer

public let leftSideReducer = Reducer<LeftSideState, LeftSideAction, LeftSideEnvironment>
{ state, action, environment in
  
  switch action {

  case .noAction:
    return .none
  }
}
//  .debug("-----> LEFTSIDEVIEW")
