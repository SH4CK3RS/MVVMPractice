//
//  MovieListItemViewModel.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/19.
//

import Foundation

struct MoviesListItemViewModel {
  let title: String
  let overview: String
  let releaseDate: String
  let posterImagPath: String?
}

extension MoviesListItemViewModel {
  init(movie: Movie) {
    self.title = movie.title ?? ""
    self.posterImagPath = movie.posterPath
    self.overview = movie.overview ?? ""
    if let releaseDate = movie.releaseDate {
      self.releaseDate = "\(NSLocalizedString("ReleaseDate", comment: "")): \(dateFormatter.string(from: releaseDate))"
    } else {
      self.releaseDate = NSLocalizedString("To be announced", comment: "")
    }
  }
}

private let dateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .medium
  return formatter
}()
