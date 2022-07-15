//
//  EventListVC + Delegate.swift
//  EventsApp
//
//  Created by macbook on 15/07/2022.
//

import Foundation
import UIKit

extension EventListVC: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    tabeView.delegate = self
    tabeView.dataSource = self
    tabeView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch viewModel.cell(at: indexPath) {
    case .event(let eventCellViewModel):
      let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
      cell.update(with: eventCellViewModel)
      return cell
    }
  }
  
}
