//
//  UIImage + Extensions.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import Foundation
import UIKit

extension UIImage {
  func sameAspectRatio(newHeight: CGFloat) -> UIImage {
    let scale = newHeight / size.height
    let newWidth = size.width * scale
    let newSize = CGSize(width: newWidth, height: newWidth)
    return UIGraphicsImageRenderer(size: newSize).image { _ in
      self.draw(in: .init(origin: .zero, size: newSize))
    }
    
  }
}
