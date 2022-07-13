//
//  RootCore.swift
//  Generic
//
//  Created by YHAN on 2022/07/13.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture

public typealias RootReducer = Reducer<RootState, RootAction, RootEnvironment>

public struct RootState: Equatable {
  public let id: UUID = .init()
  public init() {}
}

public enum RootAction {
  case splash(SplashAction)
}

public final class RootEnvironment {
  private let mainQueue: AnySchedulerOf<DispatchQueue>
  public let splash: SplashEnvironment
  
  public init(mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.mainQueue = mainQueue
    self.splash = SplashEnvironment(mainQueue: mainQueue)
  }
}

public let rootReducer: RootReducer = RootReducer.combine(
  .init() { state, action, environment in
    switch action {
    default:
      return .none
    }
  }
)
