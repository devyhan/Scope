//
//  AppCore.swift
//  App
//
//  Created by YHAN on 2022/07/13.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators
import Generic

typealias AppReducer = Reducer<AppState, AppAction, AppEnvironment>

struct AppState: Equatable {
  let id: UUID = .init()
}

enum AppAction {}

extension AppEnvironment {
  static let live: AppEnvironment = {
    let rootEnvironment = RootEnvironment(mainQueue: .main)
    let settingEnvironment = SettingEnvironment()
    
    return .init(
      mainQueue: .main,
      rootEnvironment: rootEnvironment,
      settingEnvironment: settingEnvironment
    )
  }()
}

final class AppEnvironment {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let rootEnvironment: RootEnvironment
  let settingEnvironment: SettingEnvironment
  
  init(
    mainQueue: AnySchedulerOf<DispatchQueue>,
    rootEnvironment: RootEnvironment,
    settingEnvironment: SettingEnvironment
  )
  {
    self.mainQueue = mainQueue
    self.rootEnvironment = RootEnvironment(mainQueue: mainQueue)
    self.settingEnvironment = SettingEnvironment()
  }
}

let appReducer: AppReducer = AppReducer.combine(

  .init { state, action, environment in
    switch action {
    default:
      return .none
    }
  }
)
