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
  private let imagePicker = UIImagePickerController()
  
  
  private let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
    return button
  }()
  
  private lazy var emailContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
    let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
    return view
  }()
  
  private lazy var passwordContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
    let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
    return view
  }()
  
  private lazy var fullNameContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
    let view = Utilities().inputContainerView(withImage: image, textField: fullNameTextField)
    return view
  }()
  
  private lazy var userNameContainerView: UIView = {
    let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
    let view = Utilities().inputContainerView(withImage: image, textField: userNameTextField)
    return view
  }()
  
  private let emailTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Email")
    return tf
  }()
  
  private let passwordTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let fullNameTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "Full Name")
    return tf
  }()
  
  private let userNameTextField: UITextField = {
    let tf = Utilities().textField(withPlaceholder: "User Name")
    tf.isSecureTextEntry = true
    return tf
  }()
  
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
  @objc func handleAddProfilePhoto() {
    present(imagePicker, animated: true, completion: nil)
  }
  
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Helpers
  func configureUI() {
    view.backgroundColor = .twitterBlue
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    view.addSubview(plusPhotoButton)
    plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
    plusPhotoButton.setDimensions(width: 128, height: 128)
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                               passwordContainerView,
                                               fullNameContainerView,
                                               userNameContainerView])
    stack.axis = .vertical
    stack.spacing = 20
    stack.distribution = .fillEqually
    
    view.addSubview(stack)
    stack.anchor(top: plusPhotoButton.bottomAnchor,
                 left: view.leftAnchor,
                 right: view.rightAnchor,
                 paddingTop: 32,
                 paddingLeft: 32,
                 paddingRight: 32)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                    bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                    right: view.rightAnchor,
                                    paddingLeft: 40,
                                    paddingRight: 40)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let profileImage = info[.editedImage] as? UIImage else { return }
    
    plusPhotoButton.layer.cornerRadius = 128 / 2
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.imageView?.contentMode = .scaleAspectFill
    plusPhotoButton.imageView?.clipsToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 3
    plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
    
    dismiss(animated: true, completion: nil)
  }
}
