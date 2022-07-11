import Combine
import ComposableArchitecture
import SwiftUI

public struct SplashView: View {
  let store: Store<SplashState, SplashAction>
  let statelessViewStore: ViewStore<Void, SplashAction>
  public init(store: Store<SplashState, SplashAction>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
  }
  public var body: some View {
    WithViewStore(store) { viewStore in
        Text("Splash")
    }
  }
}

struct Splash_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(
            store: Store(
                initialState: SplashState(),
                reducer: splashReducer,
                environment: SplashEnvironment(
                )
            )
        )
    }
}
