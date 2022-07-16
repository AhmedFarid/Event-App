//
//  EditEventVC.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit

class EditEventVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var viewModel: EditEventViewModel!
  
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
    
    navigationController?.navigationBar.tintColor = .black
  }
  
  @objc func tapDone() {
    viewModel.tapDone()
  }
  
}
