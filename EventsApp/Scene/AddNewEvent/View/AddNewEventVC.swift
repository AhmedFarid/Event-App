//
//  AddNewEventVC.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import UIKit

class AddNewEventVC: UIViewController {
  
  @IBOutlet weak var tableview: UITableView!
  
  var viewModel: AddEventViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    viewModel.viewDidLoad()
    initView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    viewModel.viewDidDisappear()
  }
  
  func initView() {
    navigationItem.title = viewModel.title
    navigationController?.navigationBar.prefersLargeTitles = true
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDone))
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancel))
    
    navigationController?.navigationBar.tintColor = .black
  }
  
  @objc func tapDone() {
    viewModel.tapDone()
  }
  
  @objc func tapCancel() {
    viewModel.tapCancel()
  }
}
