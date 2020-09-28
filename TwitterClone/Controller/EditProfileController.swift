//
//  EditProfileController.swift
//  TwitterClone
//
//  Created by David on 2020/9/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class EditProfileController: UITableViewController {
  // MARK: - Properties
  private let user: User
  
  // MARK: - Lifecycle
  init(user: User) {
    self.user = user
    super.init(style: .plain)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationBar()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.barStyle = .default
    navigationController?.navigationBar.isHidden = false
  }
  
  // MARK: - Selectors
  @objc func handleCancel() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc func handleDone() {
    dismiss(animated: true, completion: nil)
  }
  // MARK: - API
  // MARK: - Helpers
  func configureNavigationBar() {
    navigationController?.navigationBar.barTintColor = .twitterBlue
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.tintColor = .white
    
    navigationItem.title = "Edit Profile"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
}
