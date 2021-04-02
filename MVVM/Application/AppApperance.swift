//
//  AppApperance.swift
//  MVVM
//
//  Created by 손병근 on 2021/04/02.
//

import Foundation
import UIKit

final class AppApperance {
  static func setupAppearance() {
    UINavigationBar.appearance().barTintColor = .black
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
  }
  
}

extension UINavigationController {
  @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
