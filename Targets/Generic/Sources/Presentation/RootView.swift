//
//  Root.swift
//  Generic
//
//  Created by YHAN on 2022/07/13.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct RootView: View {
  private let store: Store<RootState, RootAction>
  private let statelessViewStore: ViewStore<Void, RootAction>
  
  public init(store: Store<RootState, RootAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  public var body: some View {
//    WithViewStore(store) { viewStore in
      ZStack {
        
        // RootCoordinator here..
        RootCoordinator(
          store: store.scope(
            state: \.rootCoordinator,
            action: RootAction.rootCoordinator
          )
        )
        
//        ScrollView {
//          LazyVStack {
//            ForEach(0...100, id: \.self) { i in
//              Group {
//                if i % 2 == 0 {
//                  Color.cyan.opacity(0.1)
//                }
//
//                if i % 3 == 0 {
//                  Color.orange.opacity(0.1)
//                }
//
//                if i % 3 == 0 {
//                  Color.green.opacity(0.1)
//                }
//              }
//              .frame(height: 100)
//            }
//          }
//        }
//        .navigationBar(title: "⌗ " + viewStore.searchQuery)
//        .onTapGesture(perform: endEditing)
      }
//    }
  }
}

#if DEBUG
struct Root_Previews: PreviewProvider {
  static var previews: some View {
    RootView(
      store: Store(
        initialState: RootState(),
        reducer: rootReducer,
        environment: RootEnvironment(mainQueue: .main)
      )
    )
  }
}
#endif
