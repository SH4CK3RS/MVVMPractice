//
//  MoviesResponseDTO+Mapping.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/21.
//

import Foundation

// MARK: - Data Transfer Object

struct MoviesResponseDTO: Decodable {
  private enum CodingKeys: String, CodingKey {
    case page
    case totalPages = "total_pages"
    case movies = "results"
  }
  
  let page: Int
  let totalPages: Int
  let movies: [MovieDTO]
}

extension MoviesResponseDTO {
  struct MovieDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
      case id
      case title
      case genre
      case posterPath = "poster_path"
      case overview
      case releaseDate = "release_date"
    }
    
    enum GenreDTO: String, Decodable {
      case adventure
      case scienceFiction = "science_fiction"
    }
    
    let id: Int
    let title: String?
    let genre: GenreDTO?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
  }
}
