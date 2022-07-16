//
//  EditEventViewModel.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import Foundation
import UIKit

final class EditEventViewModel {
  weak var coordinator: EditEventCoordinator?
  private(set) var cells: [EditEventViewModel.Cell] = []
  private let cellBuilder: EventCellBuilder
  private let coreDateManger: CoreDataManger
  
  private var nameCellViewModel: TitleSubtitleCellViewModel?
  private var dateCellViewModel: TitleSubtitleCellViewModel?
  private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
  private let event: Event
  
  lazy var dateFormater: DateFormatter = {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd.MM.yyyy"
    return dateFormater
  }()
  
  let title = "Edit Event"
  var onUpdate: () -> Void = {
    
  }
  
  enum Cell {
    case titleSubtitle(TitleSubtitleCellViewModel)
  }
  
  init(cellBuilder: EventCellBuilder,coreDateManger: CoreDataManger = CoreDataManger.shared,event: Event) {
    self.cellBuilder = cellBuilder
    self.coreDateManger = coreDateManger
    self.event = event
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
    
    coreDateManger.updateEvent(event: event,name: name, date: date, image: image)
    //tell coordinator to dismiss
    coordinator?.didFinishUpdateEvent()
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

private extension EditEventViewModel {
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
    
    guard let name = event.name, let date = event.date, let imageDate = event.image, let image = UIImage(data: imageDate) else {return}
    
    nameCellViewModel.update(name)
    dateCellViewModel.update(date)
    backgroundImageCellViewModel.update(image)
  }
  
  
}
