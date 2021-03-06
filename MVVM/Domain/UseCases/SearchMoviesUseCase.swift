//
//  SearchMoviesUseCase.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import Foundation

struct SearchMoviesUseCaseRequestValue {
  let query: MovieQuery
  let page: Int
}

protocol SearchMoviesUseCase {
  func execute(
    requestValue: SearchMoviesUseCaseRequestValue,
    cached: @escaping (MoviesPage) -> Void,
    completion: @escaping (Result<MoviesPage, Error>) -> Void
  ) -> Cancellable?
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
  
  private let moviesRepository: MoviesRepository
  private let moviewQueriesRepository: MoviesQueriesRepository
  
  init(
    moviesRepository: MoviesRepository,
    moviewQueriesRepository: MoviesQueriesRepository
  ) {
    self.moviesRepository = moviesRepository
    self.moviewQueriesRepository = moviewQueriesRepository
  }
  
  func execute(
    requestValue: SearchMoviesUseCaseRequestValue,
    cached: @escaping (MoviesPage) -> Void,
    completion: @escaping (Result<MoviesPage, Error>) -> Void
  ) -> Cancellable? {
    return moviesRepository.fetchMoviesList(
      query: requestValue.query,
      page: requestValue.page,
      cached: cached) { result in
      if case .success = result {
        self.moviewQueriesRepository.saveRecentQuery(
          query: requestValue.query
        ) { _ in }
      }
      
      completion(result)
    }
  }
}


