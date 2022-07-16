//
//  ImagePickerCoordinator.swift
//  EventsApp
//
//  Created by macbook on 15/07/2022.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
  private(set) var childCoordinators: [Coordinator] = []
  private let navigationController: UINavigationController
  var onFinishPicking: (UIImage) -> Void = {_ in}
  
  var parentCoordinator: Coordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    navigationController.present(imagePickerController, animated: true, completion: nil)
  }
  
  
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      onFinishPicking(image)
    }
    parentCoordinator?.childDidFinish(self)
  }
}
