//
//  AppConfigurations.swift
//  MVVM
//
//  Created by 손병근 on 2021/04/02.
//

import Foundation

final class AppConfiguration {
  lazy var apiKey: String = {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
      fatalError("ApiKey는 info.plist파일에 포함되어 있어야 합니다.")
    }
    
    return apiKey
  }()
  
  lazy var apiBaseURL: String = {
    guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
      fatalError("ApiBaseURL는 info.plist파일에 포함되어 있어야 합니다.")
    }
    
    return apiBaseURL
  }()
  
  
  lazy var imageBaseURL: String = {
    guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
      fatalError("ImageBaseURL는 info.plist파일에 포함되어 있어야 합니다.")
    }
    
    return imageBaseURL
  }()
  
}
