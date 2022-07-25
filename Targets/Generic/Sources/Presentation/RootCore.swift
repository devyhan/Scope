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
  public var rootCoordinator: RootCoordinatorState = .init()
  public init() {}
}

public enum RootAction {
  case splash(SplashAction)
  case rootCoordinator(RootCoordinatorAction)
}

public final class RootEnvironment {
  private let mainQueue: AnySchedulerOf<DispatchQueue>
  public let splash: SplashEnvironment
  public let main: MainEnvironment
  public let instagram: InstagramEnvironment
  
  public init(mainQueue: AnySchedulerOf<DispatchQueue>) {
    self.mainQueue = mainQueue
    self.splash = SplashEnvironment(mainQueue: mainQueue)
    self.main = MainEnvironment()
    self.instagram = InstagramEnvironment()
  }
}

public let rootReducer: RootReducer = RootReducer.combine(
  rootCoordinatorReducer
    .pullback(
      state: \RootState.rootCoordinator,
      action: /RootAction.rootCoordinator,
      environment: { $0 }
    ),
  .init() { state, action, environment in
    switch action {
      
    default:
      return .none
    }
  }
)
