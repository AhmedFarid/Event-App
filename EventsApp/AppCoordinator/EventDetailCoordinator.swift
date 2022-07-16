//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  
  private let navigationController: UINavigationController
  private let eventId: NSManagedObjectID
  
  var onUpdateEvent = {}
  
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
    onUpdateEvent =  {
      eventDetailViewModel.reload()
      self.parentCoordinator?.onUpdateEvent()
    }
    //event detail view model
    vc.viewModel = eventDetailViewModel
    // push it into navigation controller
    navigationController.pushViewController(vc, animated: true)
  }
  
  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
  
  func onEditEvent(event: Event) {
    let editEventCoordinator = EditEventCoordinator(navigationController: navigationController, event: event)
    editEventCoordinator.parentCoordinator = self
    childCoordinators.append(editEventCoordinator)
    editEventCoordinator.start()
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
  
  deinit {
    print("detail coordinator deinit")
  }
  
  
}

