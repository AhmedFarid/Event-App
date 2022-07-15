//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import UIKit

final class AddEventCoordinator: Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  private var modalNavigationController: UINavigationController?
  private var completion: (UIImage) -> Void = {_ in}
  
  var parentCoordinator: EventListCoordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  
  func start() {
    self.modalNavigationController = UINavigationController()
    
    //create add event view controller
    let vc = AddNewEventVC(nibName: "AddNewEventVC", bundle: nil)
    modalNavigationController?.setViewControllers([vc], animated: true)
    //create add event view model
    let addEventViewModel = AddEventViewModel(cellBuilder: EventCellBuilder())
    vc.viewModel = addEventViewModel
    addEventViewModel.coordinator = self
    //presents modally controller using navigation controller
    if let modalNavigationController = modalNavigationController {
      navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
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
    guard let modalNavigationController = modalNavigationController else {return}
    self.completion = completion
    let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
    imagePickerCoordinator.parentCoordinator = self
    childCoordinators.append(imagePickerCoordinator)
    imagePickerCoordinator.start()
  }
  
  func didFinishPicking(_ image: UIImage) {
      completion(image)
    modalNavigationController?.dismiss(animated: true)
  }
  
  func childDidFinish(_ childCoordinator: Coordinator) {
    if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
      return childCoordinator === coordinator
    }) {
      childCoordinators.remove(at: index)
    }
  }
  
}
