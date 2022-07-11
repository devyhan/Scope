//
//  Dependencies.swift
//  Config
//
//  Created by YHAN on 2022/07/11.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
      .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "0.35.0")),
      .remote(url: "https://github.com/johnpatrickmorgan/TCACoordinators.git", requirement: .upToNextMajor(from: "0.2.0")),
      .remote(url: "https://github.com/siteline/SwiftUI-Introspect.git", requirement: .upToNextMajor(from: "0.1.4"))
    ],
    platforms: [.iOS]
)
