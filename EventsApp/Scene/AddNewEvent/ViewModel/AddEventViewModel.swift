//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import Foundation

final class AddEventViewModel {
  weak var coordinator: AddEventCoordinator?
  private(set) var cells: [AddEventViewModel.Cell] = []
  private let cellBuilder: EventCellBuilder
  private let eventService: EventServicesProtocol
  
  private var nameCellViewModel: TitleSubtitleCellViewModel?
  private var dateCellViewModel: TitleSubtitleCellViewModel?
  private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
  
  lazy var dateFormater: DateFormatter = {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd.MM.yyyy"
    return dateFormater
  }()
  
  let title = "Add New Event"
  var onUpdate: () -> Void = {
    
  }
  
  enum Cell {
    case titleSubtitle(TitleSubtitleCellViewModel)
  }
  
  init(cellBuilder: EventCellBuilder,eventService: EventServicesProtocol = EventServices()) {
    self.cellBuilder = cellBuilder
    self.eventService = eventService
  }
  

  
  func viewDidLoad() {
    setupCells()
    onUpdate()
  }
  
  func viewDidDisappear() {
    coordinator?.didFinish()
  }
  
  func numberOfRows() -> Int {
    return cells.count
  }
  
  func cell(for indexPath: IndexPath) -> Cell {
    return cells[indexPath.row]
  }
  
  func tapDone() {
    //extract info from cell view models and save in core data
    guard let name = nameCellViewModel?.subtitle, let dateString = dateCellViewModel?.subtitle, let image = backgroundImageCellViewModel?.image, let date = dateFormater.date(from: dateString) else {return}
    
    eventService.perform(.add, data: EventServices.EventInputDate(name: name, date: date, image: image))
    //tell coordinator to dismiss
    coordinator?.didFinishSaveEvent()
  }
  
  func tapCancel() {
    //tell coordinator to dismiss
  }
  
  func updateCell(indexPath: IndexPath,subtitle: String) {
    switch cells[indexPath.row] {
    case.titleSubtitle(let titleSubtitleCellViewModel):
      titleSubtitleCellViewModel.update(subtitle)
    }
  }
  
  func didSelectRow(at indexPath: IndexPath) {
    switch cells[indexPath.row] {
    case .titleSubtitle(let titleSubtitleCellViewModel):
      guard titleSubtitleCellViewModel.type == .image else {
        return
      }
      coordinator?.showImagePicker { image in
        titleSubtitleCellViewModel.update(image)
      }
    }
  }
}

private extension AddEventViewModel {
  func setupCells() {
    nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
    dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date){[weak self] in
      guard let self = self else {return}
      self.onUpdate()
    }
    backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) {[weak self] in
      guard let self = self else {return}
      self.onUpdate()
    }
    
    guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else {return}
     
    cells = [
      .titleSubtitle(nameCellViewModel),
      .titleSubtitle(dateCellViewModel),
      .titleSubtitle(backgroundImageCellViewModel)
    ]
  }
}
