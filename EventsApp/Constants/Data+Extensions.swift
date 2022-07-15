//
//  Data+Extensions.swift
//  EventsApp
//
//  Created by macbook on 15/07/2022.
//

import Foundation

extension Date {
  func timeRemaining(until endDate: Date) -> String? {
    let dateComponentsFormatter = DateComponentsFormatter()
    dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfMonth,.day]
    dateComponentsFormatter.unitsStyle = .full
    return dateComponentsFormatter.string(from: self, to: endDate)
  }
}
