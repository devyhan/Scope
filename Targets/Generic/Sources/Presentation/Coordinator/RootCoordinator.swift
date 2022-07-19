//
//  RootCoordinator.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

// MARK: - ScreenCore

typealias RootScreenReducer = Reducer<RootScreenState, RootScreenAction, RootEnvironment>

public enum RootScreenState: Equatable, Identifiable {
  case dashboard(DashboardState)
  case instagram(InstagramState)
  
  public var id: UUID {
    switch self {
    case let .dashboard(state):
      return state.id
      
    case let .instagram(state):
      return state.id
    }
  }
}

public enum RootScreenAction {
  case dashboard(DashboardAction)
  case instagram(InstagramAction)
}

let rootScreenReducer: RootScreenReducer = RootScreenReducer.combine(
  dashboardReducer
    .pullback(
      state: /RootScreenState.dashboard,
      action: /RootScreenAction.dashboard,
      environment: { $0.dashboard }
    ),
  instagramReducer
    .pullback(
      state: /RootScreenState.instagram,
      action: /RootScreenAction.instagram,
      environment: { $0.instagram }
    )
)

// MARK: - CoordinatorCore

public typealias RootCoordinatorReducer = Reducer<RootCoordinatorState, RootCoordinatorAction, RootEnvironment>

public struct RootCoordinatorState: Equatable, IdentifiedRouterState {
  @BindableState public var searchQuery: String = String()
  @BindableState public var isSearchBarHidden: Bool = false
  public var depth: Int = 1
  
  public var routes: IdentifiedArrayOf<Route<RootScreenState>> = [.root(.dashboard(.init()))]
}

public enum RootCoordinatorAction: BindableAction, IdentifiedRouterAction {
  case binding(BindingAction<RootCoordinatorState>)
  case backToRoot
  case onCommit
  case checkToViewDepth(Int)
  case routeAction(RootScreenState.ID, action: RootScreenAction)
  case updateRoutes(IdentifiedArrayOf<Route<RootScreenState>>)
}

public let rootCoordinatorReducer: RootCoordinatorReducer = RootCoordinatorReducer.combine(
  rootScreenReducer
    .forEachIdentifiedRoute(environment: { $0 })
    .withRouteReducer(
      Reducer { state, action, environment in
        print(state.depth)
        switch action {
        case .backToRoot:
          state.routes.goBackToRoot()
          
        case .onCommit:
          if state.depth == 1 {
            switch state.searchQuery {
            case "instagram":
              state.searchQuery = String()
              state.routes.push(.instagram(.init()))
              
            default:
              break
            }
          }
          
        case let .checkToViewDepth(depth):
          state.depth = depth
          
        default:
          break
        }
        return .none
      }.binding()
    )
)

struct RootCoordinator: View {
  @FocusState private var isEditing: Bool
  private let store: Store<RootCoordinatorState, RootCoordinatorAction>
  private let statelessViewStore: ViewStore<Void, RootCoordinatorAction>
  
  init(store: Store<RootCoordinatorState, RootCoordinatorAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  var body: some View {
    TCARouter(store) { screen in
      ZStack {
        SwitchStore(screen) {
          CaseLet(
            state: /RootScreenState.dashboard,
            action: RootScreenAction.dashboard,
            then: DashboardView.init
          )
          
          CaseLet(
            state: /RootScreenState.instagram,
            action: RootScreenAction.instagram,
            then: InstagramView.init
          )
        }
        .onTapGesture(perform: endEditing)
        .navigationBarHidden(true)
        .navigationBarTitle(String())
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(StackNavigationViewStyle())
        
        WithViewStore(store) { viewStore in
          VStack(spacing: .zero) {
            Spacer()
            
            if viewStore.isSearchBarHidden {
              HStack {
                Spacer()
                Label(title: {
                  Text("다시 검색")
                    .font(.system(size: 10, weight: .light))
                }, icon: {
                  Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.black)
                })
                Spacer()
              }
              .padding(.top, 3)
              .background(.thinMaterial)
              .edgesIgnoringSafeArea(.bottom)
              .onTapGesture {
                viewStore.send(.set(\.$isSearchBarHidden, false))
                isEditing = true
              }
            } else {
              HStack {
                Menu {
                  Button {
                    viewStore.send(.set(\.$isSearchBarHidden, true))
                  } label: {
                    Label(title: {
                      Text("전체 화면으로 탐색")
                    }, icon: {
                      Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .foregroundColor(Color.white)
                    })
                  }
                  
                  if viewStore.depth != 1 {
                    Button {
                      viewStore.send(.backToRoot)
                    } label: {
                      Label(title: {
                        Text("홈 화면으로 돌아가기")
                      }, icon: {
                        Image(systemName: "arrowshape.turn.up.backward.2.fill")
                          .foregroundColor(Color.white)
                      })
                    }
                  }
                } label: {
                  Image(systemName: "option")
                    .foregroundColor(Color.white)
                }
                
                TextField(
                  "원하는 스코프를 입력하세요",
                  text: viewStore.binding(\.$searchQuery),
                  onCommit: {
                    viewStore.send(.onCommit)
                  }
                )
                .focused($isEditing)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                
                Button {
                  print("commit action")
                } label: {
                  Image(systemName: "return")
                    .foregroundColor(Color.white)
                }
              }
              .padding()
              .background(RoundedRectangle(cornerRadius: 15).fill(Color.black))
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .background(.thinMaterial)
              .frame(
                width: UIScreen.main.bounds.width,
                height: 70
              )
            }
          }
          .onChange(of: viewStore.routes) { routes in
            viewStore.send(.checkToViewDepth(routes.count))
          }
        }
      }
      .toolbar(content: toolbarView)
    }
  }
  
  private func toolbarView() -> some View {
    Button {
      print("tollbar action")
    } label: {
      Label("Settings", systemImage: "gearshape")
        .foregroundColor(Color.black)
    }
  }
  
  private func endEditing() {
    isEditing = false
  }
}
