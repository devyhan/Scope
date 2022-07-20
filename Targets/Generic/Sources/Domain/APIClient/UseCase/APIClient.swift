//
//  APIClient.swift
//  Generic
//
//  Created by YHAN on 2022/07/19.
//  Copyright © 2022 tuist.io. All rights reserved.
//

public protocol APIClient {
  func buildRequest(url: String) -> RequestBuilder
}
