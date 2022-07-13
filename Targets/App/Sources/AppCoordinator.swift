//
//  AppCoordinator.swift
//  App
//
//  Created by YHAN on 2022/07/13.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators
import Generic

// MARK: - ScreenCore

typealias AppScreenReducer = Reducer<AppScreenState, AppScreenAction, AppEnvironment>

enum AppScreenState: Equatable, Identifiable {
  case root(RootState)
  
  var id: UUID {
    switch self {
    case let .root(state):
      return state.id
    }
  }
}

enum AppScreenAction {
  case root(RootAction)
}

let appScreenReducer: AppScreenReducer = AppScreenReducer.combine(
  rootReducer
    .pullback(
      state: /AppScreenState.root,
      action: /AppScreenAction.root,
      environment: { $0.rootEnvironment }
    )
)

// MARK: - CoordinatorCore

typealias AppCoordinatorReducer = Reducer<AppCoordinatorState, AppCoordinatorAction, AppEnvironment>

struct AppCoordinatorState: Equatable, IdentifiedRouterState {
  public var splash: SplashState = .init()
  var routes: IdentifiedArrayOf<Route<AppScreenState>> = [.root(.root(.init()), embedInNavigationView: true)]
}

enum AppCoordinatorAction: IdentifiedRouterAction {
  case splash(SplashAction)
  case routeAction(AppScreenState.ID, action: AppScreenAction)
  case updateRoutes(IdentifiedArrayOf<Route<AppScreenState>>)
}

let appCoordinatorReducer: AppCoordinatorReducer = AppCoordinatorReducer.combine(
  splashReducer
    .pullback(
      state: \AppCoordinatorState.splash,
      action: /AppCoordinatorAction.splash,
      environment: { $0.rootEnvironment.splash }
    ),
  appScreenReducer
    .forEachIdentifiedRoute(environment: { $0 })
    .withRouteReducer(
      Reducer { state, action, environment in
        switch action {
        default:
          return .none
        }
      }
    )
)

struct AppCoordinator: View {
  private let store: Store<AppCoordinatorState, AppCoordinatorAction>
  
  init(store: Store<AppCoordinatorState, AppCoordinatorAction>) {
    self.store = store
  }
  
  var body: some View {
    TCARouter(store) { screen in
      ZStack {
        
        SwitchStore(screen) {
          CaseLet(
            state: /AppScreenState.root,
            action: AppScreenAction.root,
            then: RootView.init
          )
        }
        .navigationBarHidden(true)
        .navigationBarTitle(String())
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
        
        WithViewStore(store.scope(state: \.splash)) { splash in
          SplashView(
            store: store.scope(
              state: \AppCoordinatorState.splash,
              action: AppCoordinatorAction.splash
            )
          )
          .opacity(splash.isHidden ? 0 : 1)
        }
      }
    }
  }
}
