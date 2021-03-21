//
//  MoviesRequestDTO+Mapping.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/21.
//

import Foundation

struct MoviesRequestDTO: Encodable {
  let query: String
  let page: Int
}
