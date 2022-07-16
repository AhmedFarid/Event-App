//
//  EventDetailVC.swift
//  EventsApp
//
//  Created by macbook on 16/07/2022.
//

import UIKit

class EventDetailVC: UIViewController {
  
  @IBOutlet weak var eventDateLabel: UILabel!
  @IBOutlet weak var enventNameLabel: UILabel!
  @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
    didSet {
      timeRemainingStackView.setup()
    }
  }
  @IBOutlet weak var backgroundImageView: UIImageView!
  var viewModel: EventDetailViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.onUpdate = { [weak self] in
      guard let self = self else {return}
      guard let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else {return}
      self.backgroundImageView.image = self.viewModel.image
      self.eventDateLabel.text = self.viewModel.dateText
      self.enventNameLabel.text = self.viewModel.eventName
      self.timeRemainingStackView.update(with: timeRemainingViewModel)
    }
    viewModel.viewDidLoad()
    initView()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    viewModel.viewDidDisapper()
  }
  
  func initView() {
    navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
  }
}
