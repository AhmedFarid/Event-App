//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by macbook on 15/07/2022.
//

import Foundation
import UIKit

struct EventCellViewModel {
  let date = Date()
  private static let imageCache = NSCache<NSString, UIImage>()
  private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
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
  
  //  var backgroundImage: UIImage {
  // every time scroller load image
  //    guard let imageDate = event.image else {return UIImage()}
  //    return UIImage(data: imageDate) ?? UIImage()
  //  }
  
  private let event: Event
  
  init(_ event: Event) {
    self.event = event
  }
}
