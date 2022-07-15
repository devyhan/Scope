import ComposableArchitecture
import XCTest
@testable import App

final class ScopeTests: XCTestCase {
  private func test_twoPlusTwo_isFour() {
    // given
    let store = TestStore(
      initialState: AppCoordinatorState(),
      reducer: appCoordinatorReducer,
      environment: AppEnvironment(mainQueue: .main)
    )
    
    // when
//    store.send(.routeAction(.))
    // then
  }
}
