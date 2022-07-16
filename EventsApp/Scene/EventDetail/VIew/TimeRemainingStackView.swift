//
//  TimeRemainingStackView.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
  private let timeRemainingLabels = [UILabel(),UILabel(),UILabel(),UILabel()]
  
  func setup() {
    timeRemainingLabels.forEach {
      addArrangedSubview($0)
    }
    
    axis = .vertical
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func update(with viewMode: TimeRemainingViewModel) {
    timeRemainingLabels.forEach {
      $0.text = ""
      $0.font = .systemFont(ofSize: viewMode.fontSize,weight: .medium)
      $0.textColor = .white
    }
    
    viewMode.timeRemainingParts.enumerated().forEach {
      timeRemainingLabels[$0.offset].text = $0.element
    }
    
    
    alignment = viewMode.alignment
    
  }
}
