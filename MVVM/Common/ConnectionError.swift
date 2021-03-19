//
//  ConnectionError.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/19.
//

import Foundation

public protocol ConnectionError: Error {
  var isInternetConnectionError: Bool { get }
}

public extension Error {
  var isInternetConnectionError: Bool {
    guard let error = self as? ConnectionError, error.isInternetConnectionError else {
      return false
    }
    return true
  }
}
