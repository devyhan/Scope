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
    let genericSubsystem = Generic.Repositories()
    
    return .init(
      mainQueue: .main,
      rootEnvironment: rootEnvironment,
      settingEnvironment: settingEnvironment,
      genericSubsystem: genericSubsystem
    )
  }()
  
  static let mock: AppEnvironment = {
    let rootEnvironment = RootEnvironment(mainQueue: .main)
    let settingEnvironment = SettingEnvironment()
    let genericSubsystem = Generic.Repositories()
    
    return .init(
      mainQueue: .main,
      rootEnvironment: rootEnvironment,
      settingEnvironment: settingEnvironment,
      genericSubsystem: genericSubsystem
    )
  }()
}

final class AppEnvironment {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let rootEnvironment: RootEnvironment
  let settingEnvironment: SettingEnvironment
  let genericSubsystem: Generic.Subsystem
  
  init(
    mainQueue: AnySchedulerOf<DispatchQueue>,
    rootEnvironment: RootEnvironment,
    settingEnvironment: SettingEnvironment,
    genericSubsystem: Generic.Subsystem
  )
  {
    self.mainQueue = mainQueue
    self.rootEnvironment = RootEnvironment(mainQueue: mainQueue)
    self.settingEnvironment = SettingEnvironment()
    self.genericSubsystem = Generic.Repositories()
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
