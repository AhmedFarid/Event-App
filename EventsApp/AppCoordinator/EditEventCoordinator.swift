//
//  EditEventCoordinator.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit

final class EditEventCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private var completion: (UIImage) -> Void = {_ in}
  private let event: Event
  
  var parentCoordinator: EventDetailCoordinator?
  
  init(navigationController: UINavigationController, event: Event) {
    self.navigationController = navigationController
    self.event = event
  }
  
  
  func start() {
    //create add event view controller
    let vc = EditEventVC(nibName: "EditEventVC", bundle: nil)
    //create add event view model
    let editEventViewModel = EditEventViewModel(cellBuilder: EventCellBuilder(),event: event)
    vc.viewModel = editEventViewModel
    editEventViewModel.coordinator = self
    //presents modally controller using navigation controller
    navigationController.pushViewController(vc, animated: true)
  }
  
  func didFinish() {
    //navigationController.dismiss(animated: true)
    parentCoordinator?.childDidFinish(self)
  }
  
  func didFinishUpdateEvent() {
    parentCoordinator?.onUpdateEvent()
    navigationController.popViewController(animated: true)
  }
  
  func showImagePicker(completion: @escaping (UIImage) -> Void) {
    self.completion = completion
    let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
    imagePickerCoordinator.parentCoordinator = self
    imagePickerCoordinator.onFinishPicking = { image in
      completion(image)
      self.navigationController.dismiss(animated: true)
    }
    childCoordinators.append(imagePickerCoordinator)
    imagePickerCoordinator.start()
  }
    
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
  
}

