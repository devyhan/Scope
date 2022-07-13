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
  let store: Store<RootState, RootAction>
  let statelessViewStore: ViewStore<Void, RootAction>
  
  public init(store: Store<RootState, RootAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
        Text("RootView")
      }
    }
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
