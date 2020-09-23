//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by David on 2020/9/23.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
  // MARK: - Properties
  private let alreadyHaveAccountButton: UIButton = {
    let button = Utilities().attributeButton("Already have an account", " Log In")
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    configureUI()
  }
  
  // MARK: - Selectors
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Helpers
  func configureUI() {
    view.backgroundColor = .twitterBlue
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                 bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                 right: view.rightAnchor,
                                 paddingLeft: 40,
                                 paddingRight: 40)
  }
}
