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
  
}
