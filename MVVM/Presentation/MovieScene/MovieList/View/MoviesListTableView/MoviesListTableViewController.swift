//
//  MoviesListTableViewController.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/16.
//

import UIKit

class MoviesListTableViewController: UITableViewController {
  
  var viewModel: MoviesListViewModel!
  
  var posterImagesRepository: PosterImagesRepository?
  var nextPageLoadingSpinner: UIActivityIndicatorView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
    setupViews()
  }
  
  func reload() {
    tableView.reloadData()
  }
  
  func updateLoading(_ loading: MoviesListViewModelLoading?) {
    switch loading {
    case .nextPage:
      nextPageLoadingSpinner?.removeFromSuperview()
      nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
      tableView.tableFooterView = nextPageLoadingSpinner
    case .fullScreen, .none:
      tableView.tableFooterView = nil
    }
  }
  
  // MARK: - Private
  
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
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.value.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListItemCell.reuseIdentifier, for: indexPath) as? MoviesListItemCell else { assertionFailure("Cannot dequeue reusable cell \(MoviesListItemCell.self) with reuseIdentifier: \(MoviesListItemCell.reuseIdentifier)")
      return UITableViewCell()
    }
    
    cell.fill(
      with: viewModel.items.value[indexPath.row],
      posterImagesRepository: posterImagesRepository
    )
    
    if indexPath.row == viewModel.items.value.count - 1 {
      viewModel.didLoadNextPage()
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.isEmpty ? tableView.frame.height : super.tableView(tableView, heightForRowAt: indexPath)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectItem(at: indexPath.row)
  }
}
