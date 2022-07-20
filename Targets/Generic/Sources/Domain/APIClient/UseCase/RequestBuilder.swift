//
//  RequestBuilder.swift
//  Generic
//
//  Created by YHAN on 2022/07/19.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import Combine
import Foundation

public protocol RequestBuilder {
  func add(method: HTTPMethod) -> Self
  func add(headers: Dictionary<String, String>) -> Self
  func add(body: Dictionary<String, Any>) -> Self
  func add<R: Encodable>(body: R) -> Self
  func execute() -> AnyPublisher<Data, URLError>
}
