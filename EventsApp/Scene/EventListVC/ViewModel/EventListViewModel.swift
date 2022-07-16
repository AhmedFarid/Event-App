//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import Foundation

final class EventListViewModel {
  
  let title = "Events"
  var coordinator: EventListCoordinator?
  var onUpdate = {}
  
  enum Cell {
    case event(EventCellViewModel)
  }
  
  private(set) var cells: [Cell] = []
  private let eventService: EventServicesProtocol
  
  init(eventService: EventServicesProtocol = EventServices()) {
    self.eventService = eventService
  }
  
  func reload() {
    EventCellViewModel.imageCache.removeAllObjects()
    let events = eventService.getEvents()
    cells = events.map {
      var eventCellViewModel = EventCellViewModel($0)
      if let coordinator = coordinator {
        eventCellViewModel.onSelect = coordinator.onSelect
      }
      return .event(eventCellViewModel)
    }
    onUpdate()
  }
  
  func viewDidLoad() {
    reload() 
  }
  
  func tappedAddEvent() {
     coordinator?.startAddEvent()
  }
  
  func numberOfRows() -> Int {
    return cells.count
  }
  
  func cell(at indexPath: IndexPath) -> Cell {
    return cells[indexPath.row]
  }
  
  func didSelectRow(at indexPath: IndexPath) {
    switch cells[indexPath.row] {
    case .event(let eventCellViewModel):
      eventCellViewModel.didSelect()
    }
  }
}
