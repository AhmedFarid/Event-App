//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import UIKit
import CoreData

final class EventListCoordinator: Coordinator {
  
  private(set) var childCoordinators: [Coordinator] = []
  
  var onSaveEvent = {}
      
  private let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = EventListVC(nibName: "EventListVC", bundle: nil)
    let eventListViewModel = EventListViewModel()
    vc.viewModel = eventListViewModel
    onSaveEvent = eventListViewModel.reload
    eventListViewModel.coordinator = self
    navigationController.setViewControllers([vc], animated: true)
  }
  
  func onSelect(_ id: NSManagedObjectID) {
    //tigger event details coordinator
    let eventDetailCoordinator = EventDetailCoordinator(eventId: id, navigationController: navigationController)
    eventDetailCoordinator.parentCoordinator = self
    childCoordinators.append(eventDetailCoordinator)
    eventDetailCoordinator.start()
  }
  
  func startAddEvent() {
    let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
    addEventCoordinator.parentCoordinator = self
    childCoordinators.append(addEventCoordinator)
    addEventCoordinator.start()
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    print(CoreDataManger().fetchEvents().last?.name ?? "" )
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
  
}
