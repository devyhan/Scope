//
//  InstagramCore.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture

public typealias InstagramReducer = Reducer<InstagramState, InstagramAction, InstagramEnvironment>

public struct InstagramState: Equatable {
  public let id: UUID = .init()
  
  public init() {}
}

public enum InstagramAction {}

public final class InstagramEnvironment {
  public init() {}
}

let instagramReducer: InstagramReducer = InstagramReducer.combine(
  .init { state, action, environment in
    switch action {
    default:
      return .none
    }
  }
)


