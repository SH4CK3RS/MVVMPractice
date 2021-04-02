//
//  AppDIContainer.swift
//  MVVM
//
//  Created by 손병근 on 2021/04/02.
//

import Foundation

final class AppDIContainer {
  lazy var appConfiguration = AppConfiguration()
  
  // MARK: - Network
  lazy var apiDataTransferService: DataTransferService = {
    let config = ApiDataNetworkConfig(
      baseURL: URL(string: appConfiguration.apiBaseURL)!,
      queryParameters: [
        "api_key": appConfiguration.apiKey,
        "language": NSLocale.preferredLanguages.first ?? "en"
      ])
    let apiDataNetwork = DefaultNetworkService(config: config)
    return DefaultDataTransferService(with: apiDataNetwork)
  }()
  
  lazy var imageDataTransferService: DataTransferService = {
    let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.imageBaseURL)!)
    let imagesDataNetwork = DefaultNetworkService(config: config)
    return DefaultDataTransferService(with: imagesDataNetwork)
  }()
  
  // MARK: - DIContainer
  
  
}
