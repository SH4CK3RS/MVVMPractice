//
//  AppDelegate.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  let appDIContainer = AppDIContainer()
  var appFlowCoordinator: AppFlowCoordinator?
  
  
  var window: UIWindow?
  

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    AppApperance.setupAppearance()
    
    window = UIWindow()
    let navigationController = UINavigationController()
    
    window?.rootViewController = navigationController
    appFlowCoordinator = AppFlowCoordinator(
      navigationController: navigationController,
      appDiContainer: appDIContainer
    )
    
    appFlowCoordinator?.start()
    
    // Override point for customization after application launch.
    return true
  }


}

