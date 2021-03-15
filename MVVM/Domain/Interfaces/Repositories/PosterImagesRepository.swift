//
//  PosterImagesRepository.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/15.
//

import Foundation

protocol PosterImagesRepository {
  func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
