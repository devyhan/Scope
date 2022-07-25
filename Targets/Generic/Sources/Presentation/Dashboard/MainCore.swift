//
//  MainCore.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture

public typealias MainReducer = Reducer<MainState, MainAction, MainEnvironment>

public struct MainState: Equatable {
  public let id: UUID = .init()
  public init() {}
}

public enum MainAction {
  case pushToSettingView
}

public final class MainEnvironment {
  public init() {}
}

public let mainReducer: MainReducer = MainReducer.combine(
  .init() { state, action, environment in
    switch action {
    default:
      return .none
    }
  }
)
