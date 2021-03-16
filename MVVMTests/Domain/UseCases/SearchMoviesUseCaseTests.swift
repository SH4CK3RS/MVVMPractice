//
//  SearchMoviesUseCaseTests.swift
//  MVVMTests
//
//  Created by 손병근 on 2021/03/16.
//

import XCTest

class SearchMoviesUseCaseTests: XCTestCase {
  static let moviePages: [MoviesPage] = {
    let page1 = MoviesPage(page: 1, totalPage: 2, movies: [
      .stub(id: "1", title: "title1", posterPath: "/1", overview: "overview1"),
      .stub(id: "2", title: "title2", posterPath: "/2", overview: "overview2")
    ])
    let page2 = MoviesPage(page: 2, totalPage: 2, movies: [
      .stub(id: "3", title: "title3", posterPath: "/3", overview: "overview3")
    ])
    
    return [page1,page2]
  }()
  
  
}

