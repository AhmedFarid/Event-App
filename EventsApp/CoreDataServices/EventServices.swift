//
//  EventServices.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit
import CoreData

protocol EventServicesProtocol {
  func perform(_ action: EventServices.EventAction, data: EventServices.EventInputDate)
  func getEvent(_ id: NSManagedObjectID) -> Event?
  func getEvents() -> [Event]
}

final class EventServices: EventServicesProtocol {
  
  struct EventInputDate {
    let name: String
    let date: Date
    let image: UIImage
  }
  
  enum EventAction {
    case add
    case update(Event)
  }
  
  private let coreDataManger: CoreDataManger
  
  init(coredDataManger: CoreDataManger = .shared) {
    self.coreDataManger = coredDataManger
  }
  
  func perform(_ action: EventAction, data: EventInputDate) {
    var event: Event
    switch action {
    case .add:
      event = Event(context: coreDataManger.moc)
    case .update(let eventToUpdate):
      event = eventToUpdate
    }
    
    event.setValue(data.name, forKey: "name")
    
    let resizedImage = data.image.sameAspectRatio(newHeight: 250)
    let imageData = resizedImage.jpegData(compressionQuality: 0.5)
    event.setValue(imageData, forKey: "image")
    event.setValue(data.date, forKey: "date")
    coreDataManger.save()
  }
  
  func getEvent(_ id: NSManagedObjectID) -> Event? {
    return coreDataManger.get(id)
  }
  
  func getEvents() -> [Event] {
    return coreDataManger.getAll()
  }
 
//  func saveEvent() {
//      let event = Event(context: moc)
//      event.setValue(name, forKey: "name")
//
//      let resizedImage = image.sameAspectRatio(newHeight: 250)
//      let imageData = resizedImage.jpegData(compressionQuality: 0.5)
//      event.setValue(imageData, forKey: "image")
//      event.setValue(date, forKey: "date")
//      do {
//        try moc.save()
//      }catch {
//        print(error.localizedDescription)
//      }
//    }
//
//    func updateEvent(event: Event,name: String,date: Date,image: UIImage) {
//
//      do {
//        try moc.save()
//      }catch {
//        print(error.localizedDescription)
//      }
//    }
}
