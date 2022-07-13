import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
  name: "Generic",
  platform: .iOS,
  additionalTargets: [
    "ThirdPartyLibrary"
  ]
)
