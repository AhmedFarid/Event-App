//
//  EventCellBuilder.swift
//  EventsApp
//
//  Created by macbook on 15/07/2022.
//

import Foundation

struct EventCellBuilder {
  func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil)  -> TitleSubtitleCellViewModel {
    switch type {
    case .text:
      return TitleSubtitleCellViewModel(
              title: "Name",
              subtitle: "",
              placeholder: "Add a name.",
              type: .text,
              onCellUpdate: onCellUpdate
      )
    case.date:
      return TitleSubtitleCellViewModel(
        title: "Date",
        subtitle: "",
        placeholder: "Select a Date.",
        type: .date,
        onCellUpdate: onCellUpdate
      )
    case.image:
      return TitleSubtitleCellViewModel(
        title: "Background",
        subtitle: "", placeholder: "",
        type: .image,
        onCellUpdate: onCellUpdate
      )
    }
  }
}
