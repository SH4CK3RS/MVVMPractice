//
//  UITableViewController+ActivityIndicator.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/19.
//

import UIKit

extension UITableViewController {
  func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
    let style: UIActivityIndicatorView.Style
    if self.traitCollection.userInterfaceStyle == .dark {
      style = .white
    } else {
      style = .gray
    }
    
    let activityIndicator = UIActivityIndicatorView(style: style)
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
    activityIndicator.frame = .init(origin: .zero, size: size)
    
    return activityIndicator
  }
}
