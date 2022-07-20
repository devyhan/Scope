import Foundation
import XCTest
import ComposableArchitecture
@testable import Generic

final class GenericTests: XCTestCase {
  func testCheckVersion() {
    // given
    let store = TestStore(
      initialState: SplashState(),
      reducer: splashReducer,
      environment: SplashEnvironment(mainQueue: .main)
    )
    
    // when
    store.send(.checkVersion) { state in
      // then
      state.isHidden = true
    }
  }
  
  func test_onCommit_instagram_to_text_to_route_view_push() {
    
  }
}
