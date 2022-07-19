import ComposableArchitecture

public struct SplashState: Equatable {
  public var isHidden: Bool = false
  
  public init(
  ) {
  }
}

public enum SplashAction: Equatable {
  case checkVersion
}

public final class SplashEnvironment {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  
  public init(
    mainQueue: AnySchedulerOf<DispatchQueue>
  )
  {
    self.mainQueue = mainQueue
  }
}

public typealias SplashReducer = Reducer<SplashState, SplashAction, SplashEnvironment>

public let splashReducer = SplashReducer.combine(
  .init { state, action, environment in
    switch action {
    case .checkVersion:
      state.isHidden = true
      return .none
    }
  }
)
