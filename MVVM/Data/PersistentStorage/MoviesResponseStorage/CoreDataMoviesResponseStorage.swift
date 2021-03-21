//
//  CoreDataMoviesResponseStorage.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/21.
//

import Foundation
import CoreData

final class CoreDataMoviesResponseStorage {
  private let coreDataStorage: CoreDataStorage
  
  init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
    self.coreDataStorage = coreDataStorage
  }
  
  // MARK: - Private
  
  private func fetchRequest(
    for requestDto: MoviesRequestDTO
  ) -> NSFetchRequest<MoviesRequestEntity> {
    let request: NSFetchRequest = MoviesRequestEntity.fetchRequest()
    request.predicate = NSPredicate(
      format: "%K = %@ AND %K = %d",
      #keyPath(MoviesRequestEntity.query),
      requestDto.query,
      #keyPath(MoviesRequestEntity.page),
      requestDto.page
    )
    return request
  }
  
  private func deleteResponse(
    for requestDto: MoviesRequestDTO,
    in context: NSManagedObjectContext
  ) {
    let request = fetchRequest(for: requestDto)
    
    do {
      if let result = try context.fetch(request).first {
        context.delete(result)
      }
    } catch {
      print(error)
    }
  }
}

extension CoreDataMoviesResponseStorage: MoviesResponseStorage {
  func getResponse(
    for request: MoviesRequestDTO,
    completion: @escaping (Result<MoviesResponseDTO?, CoreDataStorageError>
  ) -> Void) {
    coreDataStorage.performBackgroundTask { context in
      do {
        let fetchRequest = self.fetchRequest(for: request)
        let requestEntity = try context.fetch(fetchRequest).first
        completion(.success(requestEntity?.response?.toDTO()))
      } catch {
        completion(.failure(.readError(error)))
      }
    }
  }
  
  func save(
    response: MoviesResponseDTO,
    for requestDto: MoviesRequestDTO
  ) {
    coreDataStorage.performBackgroundTask { context in
      do {
        self.deleteResponse(for: requestDto, in: context)
        
        let requestEntity = requestDto.toEntity(in: context)
        requestEntity.response = response.toEntity(in: context)
        
        try context.save()
      } catch {
        debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
      }
    }
  }
  
  
}
