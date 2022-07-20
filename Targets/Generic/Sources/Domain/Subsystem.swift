import Foundation
import ComposableArchitecture

public protocol Subsystem {
  var apiClient: APIClient { get }
}
