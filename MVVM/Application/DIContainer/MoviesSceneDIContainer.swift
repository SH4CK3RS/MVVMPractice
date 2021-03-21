//
//  MoviesSceneDIContainer.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/21.
//

import UIKit

final class MoviesSceneDIContainer {
  struct Dependencies {
    var apiDataTransferService: DataTransferService
    var imageDataTransferService: DataTransferService
  }
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
}
