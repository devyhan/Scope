import Foundation

public let env = ProjectEnvironment(
  name: "Scope",
  orgenizationName: "tuist.io",
  bundleId: "com.scope",
  targetVersion: "15.0"
)

public struct ProjectEnvironment {
  public let name: String
  public let orgenizationName: String
  public let bundleId: String
  public let targetVersion: String
  
  public init(
    name: String,
    orgenizationName: String,
    bundleId: String,
    targetVersion: String
  ) {
    self.name = name
    self.orgenizationName = orgenizationName
    self.bundleId = bundleId
    self.targetVersion = targetVersion
  }
}
