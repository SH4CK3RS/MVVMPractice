//
//  DataTransferService.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import Foundation

public enum DataTransferError: Error {
  case noResponse
  case parsing(Error)
  case netowrkFailure(NetworkError)
  case resolvedNetworkFailure(Error)
}

