//
//  TitleSubtitleCell.swift
//  EventsApp
//
//  Created by macbook on 14/07/2022.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
  let titleLabel = UILabel()
  let subtitleTextField = UITextField()
  private let verticalStackView = UIStackView()
  private let padding: CGFloat = 16
  
  private let datePickerView = UIDatePicker()
  private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 50))
  lazy var doneButton = {
    UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDoneButton))
  }()
  
  private let photoImageView = UIImageView()
  
  private var viewModel: TitleSubtitleCellViewModel?
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super .init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    verticalStackView.axis = .vertical
    titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
    subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
    
    [verticalStackView, titleLabel, subtitleTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    toolbar.setItems([doneButton], animated: true)
    datePickerView.datePickerMode = .date
    if #available(iOS 14.0, *) {
      datePickerView.preferredDatePickerStyle = .inline
    } else {
      datePickerView.preferredDatePickerStyle = .wheels
    }
    
    photoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    photoImageView.layer.cornerRadius = 8
    
  }
  
  private func setupHierarchy() {
    contentView.addSubview(verticalStackView)
    verticalStackView.addArrangedSubview(titleLabel)
    verticalStackView.addArrangedSubview(subtitleTextField)
    verticalStackView.addArrangedSubview(photoImageView)
    
    
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding),
      verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: padding),
      verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -padding),
      verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -padding)
    ])
    
    photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    
  }
  
  func update(with viewModel: TitleSubtitleCellViewModel) {
    self.viewModel = viewModel
    titleLabel.text = viewModel.title
    subtitleTextField.text = viewModel.subtitle
    subtitleTextField.placeholder = viewModel.placeholder
    
    subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
    subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
    
    photoImageView.isHidden = viewModel.type != .image
    subtitleTextField.isHidden = viewModel.type == .image
    
    photoImageView.image = viewModel.image
    
    verticalStackView.spacing = viewModel.type == .image ? 16 : verticalStackView.spacing
  }
  
  @objc func tappedDoneButton() {
    viewModel?.update(datePickerView.date)
    
  }
}

