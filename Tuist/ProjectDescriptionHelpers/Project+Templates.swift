import ProjectDescription
import ProjectEnvironment

extension Project {
  public static func app(name: String, platform: Platform, additionalProjects: [String], additionalTargets: [String]) -> Project {
    var targets = makeAppTargets(
      name: name,
      platform: platform,
      dependencies: additionalTargets.map { TargetDependency.target(name: $0) } + additionalProjects.map { TargetDependency.project(target: $0, path: .relativeToRoot("Projects/\($0)")) }
    )
    
    return Project(
      name: name,
      organizationName: env.orgenizationName,
      targets: targets,
      resourceSynthesizers: [.assets(), .strings(), .plists()]
    )
  }
  
  public static func framework(name: String, platform: Platform, additionalTargets: [String]) -> Project {
    var targets = makeFrameworkTargets(
      targetName: name,
      platform: platform,
      dependencies: additionalTargets.map { TargetDependency.target(name: $0) } + [ .target(name: "\(name)Presentation"), .target(name: "\(name)DataAccess") ]
    )
    
    targets += makeLayerTargets(projectName: name, targetName: "\(name)Presentation", platform: platform, dependencies: [.target(name: "\(name)Domain")])
    targets += makeLayerTargets(projectName: name, targetName: "\(name)DataAccess", platform: platform, dependencies: [.target(name: "\(name)Domain")])
    targets += makeLayerTargets(projectName: name, targetName: "\(name)Domain", platform: platform, dependencies: [.target(name: "ThirdPartyLibrary"), .target(name: "Resources")])
    targets += thirdPartyLibraryTargets(name: "ThirdPartyLibrary", platform: platform)
    targets += resourcesTargets(platform: platform)
    
    return Project(
      name: name,
      organizationName: env.orgenizationName,
      targets: targets
    )
  }
  
  // MARK: - Private
  
  private static func thirdPartyLibraryTargets(name: String, platform: Platform) -> [Target] {
    let sources = Target(
      name: name,
      platform: platform,
      product: .framework,
      bundleId: "\(env.bundleId).\(name)",
      deploymentTarget: .iOS(targetVersion: env.targetVersion, devices: [.iphone, .ipad]),
      sources: [],
      resources: [],
      dependencies: [
        .external(name: "ComposableArchitecture"),
        .external(name: "TCACoordinators"),
        .external(name: "Introspect")
      ]
    )
    return [sources]
  }
  
  private static func resourcesTargets(platform: Platform) -> [Target] {
    let sources = Target(
      name: "Resources",
      platform: platform,
      product: .framework,
      bundleId: "\(env.bundleId).Resources",
      deploymentTarget: .iOS(targetVersion: env.targetVersion, devices: [.iphone, .ipad]),
      sources: [],
      resources: ["../../Targets/App/Resources/**"],
      dependencies: []
    )
    return [sources]
  }
  
  private static func makeLayerTargets(projectName: String = String(), targetName: String, platform: Platform, dependencies: [TargetDependency] = []) -> [Target] {
    let sources = Target(
      name: targetName,
      platform: platform,
      product: .framework,
      bundleId: projectName != String() ? "\(env.bundleId).\(projectName).\(targetName)" : "\(env.bundleId).\(targetName)",
      deploymentTarget: .iOS(targetVersion: env.targetVersion, devices: [.iphone, .ipad]),
      sources: ["../../Targets/\(projectName)/Sources/\(targetName.contains("Presentation") ? "Presentation" : targetName.contains("Domain") ? "Domain" : targetName.contains("DataAccess") ? "DataAccess" : targetName)/**"],
      resources: [],
      dependencies: dependencies
    )
    return [sources]
  }
  
  private static func makeFrameworkTargets(projectName: String = String(), targetName: String, platform: Platform, dependencies: [TargetDependency] = []) -> [Target] {
    let sources = Target(
      name: targetName,
      platform: platform,
      product: .framework,
      bundleId: projectName != String() ? "\(env.bundleId).\(projectName).\(targetName)" : "\(env.bundleId).\(targetName)",
      deploymentTarget: .iOS(targetVersion: env.targetVersion, devices: [.iphone, .ipad]),
      infoPlist: .default,
      sources: ["../../Targets/\(targetName)/Sources/**"],
      resources: [],
      dependencies: dependencies
    )
    let tests = Target(
      name: "\(targetName)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: projectName != String() ? "\(env.bundleId).\(projectName).\(targetName)Tests" : "\(env.bundleId).\(targetName)Tests",
      infoPlist: .default,
      sources: projectName != String() ? ["../../Targets/\(projectName)/Tests/\(targetName)/**"] : ["../../Targets/\(targetName)/Tests/**"],
      resources: [],
      dependencies: [.target(name: targetName)]
    )
    if targetName != "Domain" && targetName != "Presentation" && targetName != "DataAccess" {
      return [sources, tests]
    } else {
      return [sources]
    }
  }
  
  private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
    let infoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UIMainStoryboardFile": "",
      "UILaunchStoryboardName": "LaunchScreen"
    ]
    
    let mainTarget = Target(
      name: name,
      platform: platform,
      product: .app,
      bundleId: "\(env.bundleId).\(name)",
      deploymentTarget: .iOS(targetVersion: env.targetVersion, devices: [.iphone, .ipad]),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["../../Targets/\(name)/Sources/**"],
      resources: [],
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(env.bundleId).\(name)Tests",
      infoPlist: .default,
      sources: ["../../Targets/\(name)/Tests/**"],
      dependencies: [
        .target(name: "\(name)")
      ]
    )
    return [mainTarget, testTarget]
  }
}
