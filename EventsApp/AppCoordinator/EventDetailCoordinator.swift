//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  
  private let navigationController: UINavigationController
  private let eventId: NSManagedObjectID
  
  var parentCoordinator: EventListCoordinator?
  
  init(eventId: NSManagedObjectID,navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.eventId = eventId
  }
  
  func start() {
    //create event details view controller
    let vc = EventDetailVC(nibName: "EventDetailVC", bundle: nil)
    let eventDetailViewModel = EventDetailViewModel(eventId: eventId)
    eventDetailViewModel.coordinator = self
    //event detail view model
    vc.viewModel = eventDetailViewModel
    // push it into navigation controller
    navigationController.pushViewController(vc, animated: true)
  }
  
  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
  
  func onEditEvent(event: Event) {
    
  }
  
  deinit {
    print("detail coordinator deinit")
  }
  
}

