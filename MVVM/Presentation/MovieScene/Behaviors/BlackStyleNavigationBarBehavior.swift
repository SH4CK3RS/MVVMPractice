//
//  BlackStyleNavigationBarBehavior.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/20.
//

import UIKit

class BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {
  func viewDidLoad(viewController: UIViewController) {
    viewController.navigationController?.navigationBar.barStyle = .black
  }
}
