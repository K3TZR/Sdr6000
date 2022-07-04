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
  public var panadapter: Panadapter?
  public var slice: Slice?
  public var forceUpdate = false
  public var showBands: Bool
  
  public init
  (
    panadapter: Panadapter? = nil,
    slice: Slice? = nil,
    showBands: Bool = false
  )
  {
    self.panadapter = panadapter
    self.slice = slice
    self.showBands = showBands
  }
}

public enum LeftSideAction: Equatable {
  
  case noAction
  case onAppear
  case bandChanged(String)
}

public struct LeftSideEnvironment {
  
  public init() {}
}

// ----------------------------------------------------------------------------
// MARK: - Reducer

public let leftSideReducer = Reducer<LeftSideState, LeftSideAction, LeftSideEnvironment>
{ state, action, environment in
  
  switch action {
    
  case .onAppear:
    if let slice = Model.shared.slices.first(where: {$0.active}) {
      state.slice = slice
      state.panadapter = Model.shared.panadapters[id: slice.panadapterId]
    }
    return .none

  case .bandChanged(let band):
    if let panadapter = state.panadapter {
      Panadapter.setPanadapterProperty(radio: Model.shared.radio!, id: panadapter.id, property: .band, value: band)
    }
    return .none

  case .noAction:
    return .none
  }
}
//  .debug("-----> LEFTSIDEVIEW")
