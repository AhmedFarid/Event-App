//
//  CoreDataManger.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManger {
  
  static let shared = CoreDataManger()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let persistentContainer = NSPersistentContainer(name: "EventApp")
    persistentContainer.loadPersistentStores { _, error in
      print(error?.localizedDescription ?? "")
    }
    return persistentContainer
  }()
  
  
  var moc: NSManagedObjectContext {
    persistentContainer.viewContext
  }
  

  
  func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
    do {
      return try moc.existingObject(with: id) as? T
    }catch {
      print(error.localizedDescription)
    }
    return nil
  }
  
  func getAll<T: NSManagedObject>() -> [T] {
    do {
      let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
      return try moc.fetch(fetchRequest)
    }catch {
      print(error.localizedDescription)
      return []
    }
  }
  
  func save() {
    do {
      try moc.save()
    }catch {
      print(error.localizedDescription)
    }
  }
}
