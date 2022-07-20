import ComposableArchitecture
import XCTest
@testable import App

final class ScopeTests: XCTestCase {
  func test_close_splash_screen_after_version_check() {
    let store = TestStore(
      initialState: AppCoordinatorState(),
      reducer: appCoordinatorReducer,
      environment: .mock
    )
    
    store.send(.splash(.checkVersion)) { state in
      state.splash.isHidden = true
    }
  }
}
