//
//  BackButtonEmptyTitleNavigationBarBehavior.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/20.
//

import UIKit

struct BackButtonEmptyTitleNavigationBarBehavior: ViewControllerLifecycleBehavior {
  func viewDidLoad(viewController: UIViewController) {
    viewController.navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: .plain,
      target: nil,
      action: nil
    )
  }
}
