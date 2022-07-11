import ProjectDescription
let nameAttribute: Template.Attribute = .required("name")

let testContents = """
import Foundation
import XCTest
import ComposableArchitecture
@testable import \(nameAttribute)

final class \(nameAttribute)Tests: XCTestCase {
    func testExample() {
        // Add your test here
    }
}
"""

let template = Template(
  description: "Feature template",
  attributes: [
    nameAttribute,
    .optional("platform", default: "iOS")
  ],
  items: [
    .file(path: "Targets/\(nameAttribute)/Sources/\(nameAttribute).swift", templatePath: "view.stencil"),
    .file(path: "Targets/\(nameAttribute)/Sources/\(nameAttribute)Core.swift", templatePath: "core.stencil"),
    .string(path: "Targets/\(nameAttribute)/Tests/\(nameAttribute)Tests.swift", contents: testContents),
    .file(path: "Projects/\(nameAttribute)/Project.swift", templatePath: "project.stencil"),
  ]
)
