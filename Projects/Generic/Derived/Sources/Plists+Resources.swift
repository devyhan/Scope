// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist
import Foundation
// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// MARK: - Plist Files
// swiftlint:disable identifier_name line_length number_separator type_body_length
public enum Secrets {
    #if DEBUG
    public static let baseUrl = Secrets.baseUrlDictionary["DEV"]
    #else
    public static let baseUrl = Secrets.baseUrlDictionary["PROD"]
    #endif
    public static let baseUrlDictionary: [String: Any] = ["DEV": "https://us-central1-smartgym-1204.cloudfunctions.net/devSmartGYM", "PROD": "https://us-central1-tangram-smartrope.cloudfunctions.net/liveSmartGYM"]
}
// swiftlint:enable identifier_name line_length number_separator type_body_length
// swiftlint:enable all
// swiftformat:enable all
