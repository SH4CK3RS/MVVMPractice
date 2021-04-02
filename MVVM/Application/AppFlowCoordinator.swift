//
//  AppFlowCoordinator.swift
//  MVVM
//
//  Created by 손병근 on 2021/04/02.
//

import UIKit

final class AppFlowCoordinator {
  var navigationController: UINavigationController
  private let appDiContainer: AppDIContainer
  init(navigationController: UINavigationController,
       appDiContainer: AppDIContainer) {
    self.navigationController = navigationController
    self.appDiContainer = appDiContainer
  }
  
  func start() {
    // 앱 시작시 필요한 작업들, 체크해야할 작업들을 여기서 처리
    
  }
}
