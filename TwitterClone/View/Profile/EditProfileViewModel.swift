//
//  EditProfileViewModel.swift
//  TwitterClone
//
//  Created by David on 2020/9/28.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
  case fullName
  case userName
  case bio
  
  var description: String {
    switch self {
    case .fullName: return "User Name"
    case .userName: return "Name"
    case .bio: return "Bio"      
    }
  }
}

struct EditProfileViewModel {
  private let user: User
  let option: EditProfileOptions
  
  var titleText: String {
    return option.description
  }
  
  var optionValue: String? {
    switch option {
    case .fullName: return user.fullName
    case .userName: return user.userName
    case .bio: return user.bio
    }
  }
  
  var shouldHideTextField: Bool {
    return option == .bio
  }
  
  var shouldHideTextView: Bool {
    return option != .bio
  }
  
  var shouldHidePlaceholderLabel: Bool {
    return user.bio != nil
  }
  
  init(user: User, option: EditProfileOptions) {
    self.user = user
    self.option = option
  }
}
