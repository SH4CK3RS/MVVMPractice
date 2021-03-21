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
    setupBehaviours()
    bind(to: viewModel)
    viewModel.viewDidLoad()
  }
  
  private func bind(to viewModel: MoviesListViewModel) {
    viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
    viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
    viewModel.query.observe(on: self) { [weak self] in self?.updateSearchQuery($0) }
    viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    searchController.isActive = false
  }
  
  // MARK: - Private
  
  private func setupViews() {
    title = viewModel.screenTitle
    emptyDataLabel.text = viewModel.emptyDataTitle
    setupSearchController()
  }
  
  private func setupBehaviours() {
    self.addBehaviors(
      [
        BackButtonEmptyTitleNavigationBarBehavior(),
        BlackStyleNavigationBarBehavior()
      ]
    )
  }
  
  private func updateItems() {
    moviesTableViewController?.reload()
  }
  
  private func updateLoading(_ loading: MoviesListViewModelLoading?) {
    emptyDataLabel.isHidden = true
    moviesListContainer.isHidden = true
    suggestionListContainer.isHidden = true
    LoadingView.hide()
    
    switch loading {
    case .fullScreen: LoadingView.show()
    case .nextPage: moviesListContainer.isHidden = false
    case .none:
      moviesListContainer.isHidden = viewModel.isEmpty
      emptyDataLabel.isHidden = !viewModel.isEmpty
    }
    
    moviesTableViewController?.updateLoading(loading)
    updateQueriesSuggestions()
  }
  
  private func updateQueriesSuggestions() {
    guard searchController.searchBar.isFirstResponder else {
      viewModel.closeQueriesSuggestion()
      return
    }
    viewModel.showQueriesSuggestion()
  }
  
  private func updateSearchQuery(_ query: String) {
    searchController.isActive = false
    searchController.searchBar.text = query
  }
  
  private func showError(_ error: String) {
    guard !error.isEmpty else { return }
    showAlert(title: viewModel.errorTitle, message: error)
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
