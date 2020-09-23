//
//  TweetCell.swift
//  TwitterClone
//
//  Created by David on 2020/9/24.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }    
}
