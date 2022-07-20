//
//  InstagramView.swift
//  Generic
//
//  Created by YHAN on 2022/07/18.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct InstagramView: View {
  private let store: Store<InstagramState, InstagramAction>
  private let statelessViewStore: ViewStore<Void, InstagramAction>
  
  public init(store: Store<InstagramState, InstagramAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  
  public var body: some View {
    ZStack {
      Color.black
      Text("InstagramView")
    }
    .onTapGesture(perform: endEditing)
  }
  
  private func endEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
