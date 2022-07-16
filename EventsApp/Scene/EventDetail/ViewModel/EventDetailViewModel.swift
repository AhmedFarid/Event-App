//
//  EventDetailViewModel.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import CoreData
import Foundation
import UIKit

final class EventDetailViewModel {
  
  private let eventId: NSManagedObjectID
  private let coreDateManger: CoreDataManger
  private var event: Event?
  private let date = Date()
  var onUpdate = {}
  var coordinator: EventDetailCoordinator?
  
  var image: UIImage? {
    guard let imageDate = event?.image else {return nil}
    return UIImage(data: imageDate)
  }
  
  var dateText: String? {
    guard let eventDate = event?.date else {return nil}
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd MMM yyyy"
    return dateFormater.string(from: eventDate)
  }
  
  var eventName: String? {
    event?.name
  }
  
  var timeRemainingViewModel: TimeRemainingViewModel? {
    guard let eventDate = event?.date, let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {return nil}
    
    return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)

  }
  
  init(eventId: NSManagedObjectID, coreDataManger: CoreDataManger = .shared) {
    self.eventId = eventId
    self.coreDateManger = coreDataManger
  }
  
  func viewDidLoad() {
    event = coreDateManger.getEvent(eventId)
    onUpdate()
  }
  
  func viewDidDisapper() {
    coordinator?.didFinish()
  }
  
  @objc func editButtonTapped() {
    guard let event = event else {return}
    //coordinator?.onEditEvent(event) {
      
    //}
  }
  
}
