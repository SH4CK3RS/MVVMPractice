//
//  Movie.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import Foundation

struct Movie: Equatable, Identifiable {
  typealias Identifier = String
  enum Genre {
    case adventure
    case scienceFiction
  }
  
  let id: Identifier
  let title: String?
  let genre: Genre?
  let posterPath: String?
  let overview: String?
  let releaseDate: Date?
}

struct MoviesPage: Equatable {
  let page: Int
  let totalPage: Int
  let movies: [Movie]
}
