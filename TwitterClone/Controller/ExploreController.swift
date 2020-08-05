//
//  ExploreController.swift
//  TwitterClone
//
//  Created by David on 2020/8/5.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
  
  // MARK: - Properties
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Helpers
  func configureUI() {
    view.backgroundColor = .white
    
    navigationItem.title = "Explore"
  }
}
