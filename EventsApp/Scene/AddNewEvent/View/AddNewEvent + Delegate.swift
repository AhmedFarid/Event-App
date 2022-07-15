//
//  AddNewEvent + Delegate.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import UIKit

extension AddNewEventVC: UITableViewDataSource, UITableViewDelegate {
  
  func setupTableView() {
    tableview.dataSource = self
    tableview.delegate = self
    tableview.register(TitleSubtitleCell.self, forCellReuseIdentifier: "TitleSubtitleCell")
    
    //to force large titel
    tableview.setContentOffset(.init(x: 0, y: -1), animated: true)
    tableview.contentInsetAdjustmentBehavior = .never
    tableview.tableFooterView = UIView()
    
    viewModel.onUpdate = { [weak self] in
      guard let self = self else {return}
      self.tableview.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellViewModel = viewModel.cell(for: indexPath)
    switch cellViewModel {
    case .titleSubtitle(let titleSubtitleCellViewModel):
      let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSubtitleCell", for: indexPath) as! TitleSubtitleCell
      cell.update(with: titleSubtitleCellViewModel)
      cell.subtitleTextField.delegate = self
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectRow(at: indexPath)
  }
}

extension AddNewEventVC: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let currentText = textField.text else {return false}
    let text = currentText + string
    
    let point = textField.convert(textField.bounds.origin, to: tableview)
    if let indexPath = tableview.indexPathForRow(at: point) {
      viewModel.updateCell(indexPath: indexPath,subtitle: text)
    } 
    return true
  }
}
