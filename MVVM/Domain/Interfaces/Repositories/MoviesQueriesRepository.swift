//
//  MoviesQueriesRepository.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import Foundation

protocol MoviesQueriesRepository {
  func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[MovieQuery], Error>) -> Void)
  func saveRecentQuery(query: MovieQuery, completion: @escaping (Result<MovieQuery, Error>) -> Void)
}
