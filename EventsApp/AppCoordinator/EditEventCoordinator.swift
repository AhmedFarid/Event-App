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
  
  var parentCoordinator: EventListCoordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  
  func start() {
    //create add event view controller
    //let vc = EditEventVC(nibName: "EditEventVC", bundle: nil)
    //create add event view model
    //let editEventViewModel = EditEventViewModel(cellBuilder: EventCellBuilder())
    //vc.viewModel = editEventViewModel
    //editEventViewModel.coordinator = self
    //presents modally controller using navigation controller
//    navigationController.present(modalNavigationController, animated: true, completion: nil)
  }
  
  func didFinish() {
    //navigationController.dismiss(animated: true)
    parentCoordinator?.childDidFinish(self)
  }
  
  func didFinishSaveEvent() {
    parentCoordinator?.onSaveEvent()
    navigationController.dismiss(animated: true)
  }
  
  func showImagePicker(completion: @escaping (UIImage) -> Void) {
    self.completion = completion
    let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
    imagePickerCoordinator.parentCoordinator = self
    childCoordinators.append(imagePickerCoordinator)
    imagePickerCoordinator.start()
  }
  
  func didFinishPicking(_ image: UIImage) {
      completion(image)
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
  
}

