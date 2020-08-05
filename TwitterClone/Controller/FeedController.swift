//
//  FeedController.swift
//  TwitterClone
//
//  Created by David on 2020/8/5.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
  
  // MARK: - Properties
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Helpers
  func configureUI() {
    view.backgroundColor = .white
    
    let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
    imageView.contentMode = .scaleAspectFit
    navigationItem.titleView = imageView
  }
}
