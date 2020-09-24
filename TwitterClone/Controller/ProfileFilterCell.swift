//
//  ProfileFilterCell.swift
//  TwitterClone
//
//  Created by David on 2020/9/25.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
  // MARK: - Properties
  let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = UIFont.systemFont(ofSize: 14)
    label.text = "Test filter"
    return label
  }()
  
  override var isSelected: Bool {
    didSet {
      titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
      titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
    }
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    
    addSubview(titleLabel)
    titleLabel.center(inView: self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
