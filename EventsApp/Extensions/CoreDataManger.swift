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
  
  func saveEvent(name: String,date: Date,image: UIImage) {
    let event = Event(context: moc)
    event.setValue(name, forKey: "name")
    
    let resizedImage = image.sameAspectRatio(newHeight: 250)
    let imageData = resizedImage.jpegData(compressionQuality: 0.5)
    event.setValue(imageData, forKey: "image")
    event.setValue(date, forKey: "date")
    do {
      try moc.save()
    }catch {
      print(error.localizedDescription)
    }
  }
  
  func getEvent(_ id: NSManagedObjectID) -> Event? {
    do {
      return try moc.existingObject(with: id) as? Event
    }catch {
      print(error.localizedDescription)
    }
    return nil
  }
  
  func fetchEvents() -> [Event] {
    do {
      let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
      let events = try moc.fetch(fetchRequest)
      return events
    }catch {
      print(error.localizedDescription)
      return []
    }
  }
}