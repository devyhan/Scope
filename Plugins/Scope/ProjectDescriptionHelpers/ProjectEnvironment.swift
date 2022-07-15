import Foundation

public let env = ProjectEnvironment(
  name: "Scope",
  orgenizationName: "tuist.io",
  bundleId: "com.scope"
)

public struct ProjectEnvironment {
  public let name: String
  public let orgenizationName: String
  public let bundleId: String
  
  public init(
    name: String,
    orgenizationName: String,
    bundleId: String
  ) {
    self.name = name
    self.orgenizationName = orgenizationName
    self.bundleId = bundleId
  }
}
