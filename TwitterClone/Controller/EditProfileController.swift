//
//  EditProfileController.swift
//  TwitterClone
//
//  Created by David on 2020/9/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

private let reuseIdentifier = "EditProfileCell"

protocol EditProfileControllerDelegate: class {
  func controller(_ controller: EditProfileController, wantsToUpdate user: User)
  func handleLogout()
}

class EditProfileController: UITableViewController {
  // MARK: - Properties
  private var user: User
  private lazy var headerView = EditProfileHeader(user: user)
  private let footerView = EditProfileFooter()
  private let imagePicker = UIImagePickerController()
  weak var delegate: EditProfileControllerDelegate?
  
  private var userInfoChanged = false
  
  private var imageChanged: Bool {
    return selectedImage != nil
  }
  
  private var selectedImage: UIImage? {
    didSet {
      headerView.profileImageView.image = selectedImage
    }
  }
  
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
        
    configureImagePicker()
    configureNavigationBar()
    configureTableView()
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
    view.endEditing(true)
    guard imageChanged || userInfoChanged else { return }
    
    updateUserData()
  }
  // MARK: - API
  func updateUserData() {
    if imageChanged && !userInfoChanged {
      print("Changed image and not data")
      updateProfileImage()
    }
    
    if userInfoChanged && !imageChanged {
      print("Changed data and not image")
      UserService.shared.saveUserData(user: user) { (err, ref) in
        self.delegate?.controller(self, wantsToUpdate: self.user)
      }
    }
    
    if userInfoChanged && imageChanged {
      print("Changed both")
      UserService.shared.saveUserData(user: user) { (err, ref) in
        self.updateProfileImage()
      }
    }
  }
  
  func updateProfileImage() {
    guard let image = selectedImage else { return }
    
    UserService.shared.updateProfileImage(image: image) { profileImageUrl in
      self.user.profileImageUrl = profileImageUrl
      self.delegate?.controller(self, wantsToUpdate: self.user)
    }
  }
  
  // MARK: - Helpers
  func configureNavigationBar() {
    navigationController?.navigationBar.barTintColor = .twitterBlue
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.tintColor = .white
    
    navigationItem.title = "Edit Profile"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
  }
  
  func configureTableView() {
    tableView.tableHeaderView = headerView
    headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
    headerView.delegate = self
    
    footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    tableView.tableFooterView = footerView
    footerView.delegate = self
    
    tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
  }
  
  func configureImagePicker() {
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
  }
}

// MARK: - UITableViewDataSource
extension EditProfileController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return EditProfileOptions.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
    cell.delegate = self
    
    guard let option = EditProfileOptions(rawValue: indexPath.row) else { return cell}
    cell.viewModel = EditProfileViewModel(user: user, option: option)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension EditProfileController {
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0 }
    return option == .bio ? 100 : 48
  }
}

// MARK: - EditProfileHeaderDelegate
extension EditProfileController: EditProfileHeaderDelegate {
  func didTapChangeProfilePhoto() {
    present(imagePicker, animated: true, completion: nil)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    self.selectedImage = image
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - EditProfileCellDelegate
extension EditProfileController: EditProfileCellDelegate {
  func updateUserInfo(_ cell: EditProfileCell) {
    guard let viewModel = cell.viewModel else { return }
    userInfoChanged = true
    navigationItem.rightBarButtonItem?.isEnabled = true
    
    switch viewModel.option {
    case .fullName:
      guard let fullName = cell.infoTextField.text else { return }
      user.fullName = fullName
    case .userName:
      guard let userName = cell.infoTextField.text else { return }
      user.userName = userName
    case .bio:
      user.bio = cell.bioTextView.text
    }
  }
}

// MARK: - EditProfileFooterDelegate
extension EditProfileController: EditProfileFooterDelegate {
  func handleLogout() {
    let alert = UIAlertController(title: nil, message: "Are you sure you want to log out", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
      self.dismiss(animated: true) {
        self.delegate?.handleLogout()
      }      
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(alert, animated: true, completion: nil)
  }
}
