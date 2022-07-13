//
//  AppContainer.swift
//  App
//
//  Created by YHAN on 2022/07/13.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@main
struct AppContainer: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      AppCoordinator(
        store: Store(
          initialState: AppCoordinatorState(),
          reducer: appCoordinatorReducer,
          environment: .live
        )
      )
    }
  }
}
