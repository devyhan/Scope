//
//  DashboardView.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct DashboardView: View {
  private let store: Store<DashboardState, DashboardAction>
  private let statelessViewStore: ViewStore<Void, DashboardAction>
  
  init(store: Store<DashboardState, DashboardAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
        Color.blue
      }
    }
    .navigationBar(
      title: "DashBoard",
      leftBarButtonItem: { EmptyView() },
      rightBarButtonItem: rightBarButtonItem
    )
  }
  
  private func rightBarButtonItem() -> some View {
    Image(systemName: "gear")
      .onTapGesture(perform: rightBarButtonDidTap)
      .padding(.trailing, 15)
  }
  
  private func rightBarButtonDidTap() {
    statelessViewStore.send(.pushToSettingView)
  }
}
