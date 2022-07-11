import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// MARK: - Project

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.app(
  name: "App",
  platform: .iOS,
  additionalProjects: [
    "Splash"
  ],
  additionalTargets: [
  ]
)
