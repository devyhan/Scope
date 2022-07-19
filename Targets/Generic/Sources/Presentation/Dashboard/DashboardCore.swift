//
//  DashboardCore.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture

public typealias DashboardReducer = Reducer<DashboardState, DashboardAction, DashboardEnvironment>

public struct DashboardState: Equatable {
  public let id: UUID = .init()
  public init() {}
}

public enum DashboardAction {
  case pushToSettingView
}

public final class DashboardEnvironment {
  public init() {}
}

public let dashboardReducer: DashboardReducer = DashboardReducer.combine(
  .init() { state, action, environment in
    switch action {
    default:
      return .none
    }
  }
)
