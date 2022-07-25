//
//  MainView.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import MapKit

public struct MainView: View {
  private let store: Store<MainState, MainAction>
  private let statelessViewStore: ViewStore<Void, MainAction>
  
  init(store: Store<MainState, MainAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ZStack {
        MapView(
          mapViewDidChangeVisibleRegion: mapViewDidChangeVisibleRegion
        )
          .ignoresSafeArea()
      }
    }
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

// MARK: - MapViewDelegate

extension MainView {
  private func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
    print(mapView)
  }
}
