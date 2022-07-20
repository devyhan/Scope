//
//  APIClientImpl.swift
//  Generic
//
//  Created by YHAN on 2022/07/19.
//  Copyright © 2022 tuist.io. All rights reserved.
//

import Foundation
import GenericDomain

public final class APIClientImpl: APIClient {
  public func buildRequest(url: String) -> RequestBuilder {
    let url: URL = {
      guard let url = URL(string: url) else { return URL(string: "")! }
      return url
    }()
    let requestURL = URLRequest(url: url)
    
    return RequestBuilderImpl(url: requestURL)
  }
}
