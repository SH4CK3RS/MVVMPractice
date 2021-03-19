//
//  MoviesListViewController.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/20.
//

import UIKit

class MoviesListViewController: UIViewController, Alertable {
  private var viewModel: MoviesListViewModel!
  private var posterImagesRepository: PosterImagesRepository?
  
  private var moviesTableViewController: MoviesListTableViewController?
  private var searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - Views
  private var contentView: UIView = {
    let view = UIView()
    
    return view
  }()
  
  private var moviesListContainer: UIView = {
    let view = UIView()
    
    return view
  }()
  
  private(set) var suggestionListContainer: UIView = {
    let view = UIView()
    
    return view
  }()
  
  private var searchBarContainer: UIView = {
    let view = UIView()
    
    return view
  }()
  
  private var emptyDataLabel: UILabel = {
    let label = UILabel()
    
    return label
  }()
  
  
  
  // MARK: - LifeCycle
  
  static func create(
    with viewModel: MoviesListViewModel,
    posterImagesRepository: PosterImagesRepository?
  ) -> MoviesListViewController {
    let view = MoviesListViewController()
    view.viewModel = viewModel
    view.posterImagesRepository = posterImagesRepository
    return view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    bind(to: viewModel)
    viewModel.viewDidLoad()
  }
  
  
  
  private func bind(to viewModel: MoviesListViewModel) {
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    searchController.isActive = false
  }
  
  
  private func setupViews() {
    title = viewModel.screenTitle
    emptyDataLabel.text = viewModel.emptyDataTitle
    setupSearchController()
  }
  
  private func setupSearchController() {
    searchController.delegate = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = viewModel.searchBarPlaceHolder
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
    searchController.searchBar.barStyle = .black
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.frame = searchBarContainer.bounds
    searchController.searchBar.autoresizingMask = [.flexibleWidth]
    searchBarContainer.addSubview(searchController.searchBar)
    definesPresentationContext = true
    if #available(iOS 13.0, *) {
        searchController.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.searchField
    }
  }
}

extension MoviesListViewController: UISearchBarDelegate {
  
}

extension MoviesListViewController: UISearchControllerDelegate {
  
}
