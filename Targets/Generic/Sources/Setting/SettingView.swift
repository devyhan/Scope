//
//  SettingView.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct SettingView: View {
  private let store: Store<SettingState, SettingAction>
  private let statelessViewStore: ViewStore<Void, SettingAction>
  
  public init(store: Store<SettingState, SettingAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
        Color.black
        Text("SettingView")
      }
    }
    .border(Color.red)
  }
}
