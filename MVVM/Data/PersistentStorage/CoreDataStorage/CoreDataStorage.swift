//
//  CoreDataStorage.swift
//  MVVM
//
//  Created by 손병근 on 2021/03/21.
//

import CoreData

enum CoreDataStorageError: Error {
  case readError(Error)
  case saveError(Error)
  case deleteError(Error)
}

final class CoreDataStorage {
  static let shared = CoreDataStorage()
  
  private init() {}
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreDataStorage")
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
      }
      
    }
    return container
  }()
  
  func saveContext() {
    let contenxt = persistentContainer.viewContext
    if contenxt.hasChanges {
      do {
        try contenxt.save()
        
      } catch {
        assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
      }
    }
  }
  
  func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
    persistentContainer.performBackgroundTask(block)
  }
}
