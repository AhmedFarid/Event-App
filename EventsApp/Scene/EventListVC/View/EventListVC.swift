//
//  EventListVC.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import UIKit
import CoreData

class EventListVC: UIViewController {
  
  @IBOutlet weak var tabeView: UITableView!
  
  var viewModel: EventListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
    setupTableView()
    viewModel.viewDidLoad()
    
    viewModel.onUpdate = { [weak self] in
      
      guard let self = self else {return}
      self.tabeView.reloadData()
    }
  }
  
  private func initView() {
    let plusImage = UIImage(systemName: "plus.circle.fill")
    let barButtonItem = UIBarButtonItem(image: plusImage,style: .plain, target: self, action: #selector(tappedAddEventButton))
    barButtonItem.tintColor = .primary
    navigationItem.rightBarButtonItem = barButtonItem
    navigationItem.title = viewModel.title
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @objc private func tappedAddEventButton() {
    viewModel.tappedAddEvent()
  }
  
}
