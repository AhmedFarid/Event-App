//
//  EditEvent + Delegate.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit

extension EditEventVC: UITableViewDataSource, UITableViewDelegate {
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: "TitleSubtitleCell")
    
    //to force large titel
    tableView.setContentOffset(.init(x: 0, y: -1), animated: true)
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.tableFooterView = UIView()
    
    viewModel.onUpdate = { [weak self] in
      guard let self = self else {return}
      self.tableView.reloadData()
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

extension EditEventVC: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let currentText = textField.text else {return false}
    let text = currentText + string
    
    let point = textField.convert(textField.bounds.origin, to: tableView)
    if let indexPath = tableView.indexPathForRow(at: point) {
      viewModel.updateCell(indexPath: indexPath,subtitle: text)
    }
    return true
  }
}
