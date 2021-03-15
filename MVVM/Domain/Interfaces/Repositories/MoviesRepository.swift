//
//  MoviesRepository.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import Foundation

protocol MoviesRepository {
  @discardableResult
  func fetchMoviesList(
    query: MovieQuery, page: Int,
    cached: @escaping (MoviesPage) -> Void,
    completion: @escaping (Result<MoviesPage, Error>) -> Void
  ) -> Cancellable?
}


