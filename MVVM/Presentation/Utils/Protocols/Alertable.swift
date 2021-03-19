//
//  Alertable.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/20.
//

import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
  func showAlert(
    title: String = "",
    message: String,
    preferredStyle: UIAlertController.Style = .alert,
    completion: (() -> Void)? = nil
  ) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: preferredStyle
    )
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: completion)
  }
}

