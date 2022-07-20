import ComposableArchitecture
import GenericDomain

public final class Repositories: Subsystem {
  public var apiClient: APIClient
  
  public init() {
    self.apiClient = APIClientImpl()
  }
}
