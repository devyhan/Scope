import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "Splash",
  platform: .iOS,
  additionalTargets: [
    "ThirdPartyLibrary"
  ]
)
