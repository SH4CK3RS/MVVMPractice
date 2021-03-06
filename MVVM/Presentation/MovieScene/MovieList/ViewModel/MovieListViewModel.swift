//
//  MovieListViewModel.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/19.
//

import Foundation

struct MoviesListViewModelActions {
  let showMovieDetails: (Movie) -> Void
  let showMovieQueriesSuggestions: (@escaping (_ didSelect: MovieQuery) -> Void) -> Void
  let closeMoviesQueriesSuggestions: () -> Void
}

enum MoviesListViewModelLoading {
  case fullScreen
  case nextPage
}

protocol MoviesListViewModelInput {
  func viewDidLoad()
  func didLoadNextPage()
  func didSearch(query: String)
  func didCancelSearch ()
  func showQueriesSuggestion()
  func closeQueriesSuggestion()
  func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput {
  var items: Observable<[MoviesListItemViewModel]> { get }
  var loading: Observable<MoviesListViewModelLoading?> { get }
  var query: Observable<String> { get }
  var error: Observable<String> { get }
  var isEmpty: Bool { get }
  var screenTitle: String { get }
  var emptyDataTitle: String { get }
  var errorTitle: String { get }
  var searchBarPlaceHolder: String { get }
}

protocol MoviesListViewModel: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class DefaultMoviesListViewModel: MoviesListViewModel {
  
  private let searchMoviesUseCase: SearchMoviesUseCase
  private let actions: MoviesListViewModelActions?
  
  var currentPage: Int = 0
  var totalPageCount: Int = 1
  var hasMorePages: Bool { currentPage < totalPageCount }
  var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
  
  private var pages: [MoviesPage] = []
  private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
  
  // MARK: - OUTPUT
  let items: Observable<[MoviesListItemViewModel]> = Observable([])
  let loading: Observable<MoviesListViewModelLoading?> = Observable(.none)
  let query: Observable<String> = Observable("")
  let error: Observable<String> = Observable("")
  var isEmpty: Bool { return items.value.isEmpty }
  let screenTitle = NSLocalizedString("Movies", comment: "")
  let emptyDataTitle = NSLocalizedString("Search Results", comment: "")
  let errorTitle: String = NSLocalizedString("Error", comment: "")
  let searchBarPlaceHolder: String = NSLocalizedString("Search Movies", comment: "")
  
  // MARK: - Init
  init(
    searchMoviesUseCase: SearchMoviesUseCase,
    actions: MoviesListViewModelActions? = nil
  ) {
    self.searchMoviesUseCase = searchMoviesUseCase
    self.actions = actions
  }
  
  // MARK: Private
  private func appendPage(_ moviesPage: MoviesPage) {
    currentPage = moviesPage.page
    totalPageCount = moviesPage.totalPage
    
    pages = pages
      .filter { $0.page != moviesPage.page }
    
    items.value = pages.movies.map(MoviesListItemViewModel.init)
  }
  
  private func resetPages() {
    currentPage = 0
    totalPageCount = 1
    pages.removeAll()
    items.value.removeAll()
  }
  
  private func load(movieQuery: MovieQuery, loading: MoviesListViewModelLoading) {
    self.loading.value = loading
    query.value = movieQuery.query
    
    moviesLoadTask = searchMoviesUseCase.execute(
      requestValue: .init(query: movieQuery, page: nextPage),
      cached: appendPage,
      completion: { result in
        switch result {
        case .success(let page):
          self.appendPage(page)
        case .failure(let error):
          self.handle(error: error)
        }
        self.loading.value = .none
      })
  }
  
  private func handle(error: Error) {
    self.error.value = error.isInternetConnectionError ?
      NSLocalizedString("No internet connection", comment: "") :
      NSLocalizedString("Failed loading movies", comment: "")
  }
  
  private func update(movieQuery: MovieQuery) {
    resetPages()
    load(movieQuery: movieQuery, loading: .fullScreen)
  }
}



extension DefaultMoviesListViewModel: MoviesListViewModelInput {
  func viewDidLoad() {
    
  }
  
  func didLoadNextPage() {
    guard hasMorePages, loading.value == .none else { return }
    load(
      movieQuery: .init(query: query.value),
      loading: .nextPage
    )
  }
  
  func didSearch(query: String) {
    guard !query.isEmpty else { return }
    update(movieQuery: MovieQuery(query: query))
  }
  
  func didCancelSearch() {
    moviesLoadTask?.cancel()
  }
  
  func showQueriesSuggestion() {
    actions?.showMovieQueriesSuggestions(update(movieQuery:))
  }
  
  func closeQueriesSuggestion() {
    actions?.closeMoviesQueriesSuggestions()
  }
  
  func didSelectItem(at index: Int) {
    actions?.showMovieDetails(pages.movies[index])
  }
}

// MARK: - Private

private extension Array where Element == MoviesPage {
  var movies: [Movie] { flatMap { $0.movies } }
}
