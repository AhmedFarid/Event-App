//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by macbook on 15/07/2022.
//

import CoreData
import UIKit

struct EventCellViewModel {
  let date = Date()
  static let imageCache = NSCache<NSString, UIImage>()
  private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
  
  var onSelect: (NSManagedObjectID) -> Void = {_ in}
  
  private var cacheKey: String {
    event.objectID.description
  }
  
  var timeRemainingStrings: [String] {
    //1 year, 1 month, 2 weeks, 1 day
    guard let eventDate = event.date else {return []}
    return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
  }
  
  var dateText: String? {
    guard let eventDate = event.date else {return nil}
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd MMM yyyy"
    return dateFormater.string(from: eventDate)
  }
  
  var eventName: String? {
    event.name
  }
  
  var timeRemainingViewModel: TimeRemainingViewModel? {
    guard let eventDate = event.date, let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {return nil}
    
    return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
  }
  
  
  func loadImage(completion: @escaping (UIImage?) -> Void) {
    //check image cache for a value of the cache key and complete with this image value
    if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
      completion(image)
    }else {
      //load new imag
      imageQueue.async {
        guard let imageDate = self.event.image, let image = UIImage(data: imageDate) else {
          completion(nil)
          return
        }
        Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
        DispatchQueue.main.async {
          completion(image)
        }
      }
    }
  }
  
  func didSelect() {
    onSelect(event.objectID)
  }
  
  
  private let event: Event
  
  init(_ event: Event) {
    self.event = event
  }
}
