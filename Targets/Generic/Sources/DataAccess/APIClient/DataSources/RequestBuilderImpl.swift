//
//  RequestBuilderImpl.swift
//  GenericDomain
//
//  Created by YHAN on 2022/07/19.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import Combine
import Foundation
import GenericDomain

public final class RequestBuilderImpl: RequestBuilder {
  var url: URLRequest
  
  init(url: URLRequest) {
    self.url = url
  }
  
  public func add(method: HTTPMethod) -> Self {
    url.httpMethod = method.rawValue
    return self
  }
  
  public func add(headers: Dictionary<String, String>) -> Self {
    for header in headers {
      url.addValue(header.value, forHTTPHeaderField: header.key)
    }
    return self
  }
  
  public func add(body: Dictionary<String, Any>) -> Self {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
      url.httpBody = jsonData
    } catch {
      print("Error \(error)")
    }
    return self
  }
  
  public func add<R: Encodable>(body: R) -> Self {
    let jsonEncoder = JSONEncoder()
    do {
      let jsonData = try jsonEncoder.encode(body)
      url.httpBody = jsonData
    } catch {
      print("Error \(error)")
    }
    return self
  }
  
  public func execute() -> AnyPublisher<Data, URLError> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { data, response in
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          switch statusCode {
          case 404:
            print("return to 404 status code")
          case 200:
            print("return to 200 status code")
          default:
            print("return to unknown status code")
            break
          }
        }
        return data
      }
      .eraseToAnyPublisher()
  }
}
