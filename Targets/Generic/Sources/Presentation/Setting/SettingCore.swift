//
//  SettingCore.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture

public typealias SettingReducer = Reducer<SettingState, SettingAction, SettingEnvironment>

public struct SettingState: Equatable {
  public let id: UUID = .init()
  public init() {}
}

public enum SettingAction {
  
}

public final class SettingEnvironment {
  public init() {}
}

public let settingReducer: SettingReducer = SettingReducer.combine(
  .init() { state, action, environment in
    switch action {
    default:
      return .none
    }
  }
)
