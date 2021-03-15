//
//  MoviesListTableViewController.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/16.
//

import UIKit

class MoviesListTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
    setupViews()
  }
  
  func reload() {
    tableView.reloadData()
  }
  
  private func registerCell() {
    self.tableView.register(MoviesListItemCell.self, forCellReuseIdentifier: MoviesListItemCell.reuseIdentifier)
  }
  
  private func setupViews() {
    tableView.estimatedRowHeight = MoviesListItemCell.height
    tableView.rowHeight = UITableView.automaticDimension
  }
}

// MARK: - TableViewDataSource, TableViewDelegate Implementation

extension MoviesListTableViewController {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListItemCell.reuseIdentifier, for: indexPath) as? MoviesListItemCell else { assertionFailure("Cannot dequeue reusable cell \(MoviesListItemCell.self) with reuseIdentifier: \(MoviesListItemCell.reuseIdentifier)")
      return UITableViewCell()
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    <#code#>
  }
}
