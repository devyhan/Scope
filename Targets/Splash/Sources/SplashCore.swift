import ComposableArchitecture

public struct SplashState: Equatable {
  public init(
  ) {
  }
}

public enum SplashAction: Equatable {}

public typealias SplashReducer = Reducer<SplashState, SplashAction, AppEnvironment>

public let splashReducer = SplashReducer.combine(
  .init { state, action, environment in
    switch action {
    }
  }
)
