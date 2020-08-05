//
//  LoginController.swift
//  TwitterClone
//
//  Created by David on 2020/8/5.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
  // MARK: - Properties
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Selectors
  
  // MARK: - Helpers
  func configureUI() {
    view.backgroundColor = .twitterBlue
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isHidden = true        
  }
}
