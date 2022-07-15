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
  private let coreDateManger: CoreDataManger
  
  init(coreDateManger: CoreDataManger = CoreDataManger.shared) {
    self.coreDateManger = coreDateManger
  }
  
  func reload() {
    let events = coreDateManger.fetchEvents()
    
    cells = events.map {
      .event(EventCellViewModel($0))
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
}
