//
//  MoviesResponseStorage.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/21.
//

import Foundation

protocol MoviesResponseStorage {
  func getResponse(
    for request: MoviesRequestDTO,
    completion: @escaping (Result<MoviesResponseDTO?, CoreDataStorageError>) -> Void
  )
  
  func save(
    response: MoviesResponseDTO,
    for requestDto: MoviesRequestDTO
  )
}
