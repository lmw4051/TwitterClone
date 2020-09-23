//
//  User.swift
//  TwitterClone
//
//  Created by David on 2020/9/23.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

struct User {
  let fullName: String
  let email: String
  let userName: String
  let profileImageUrl: String
  let uid: String
  
  init(uid: String, dictionary: [String: AnyObject]) {
    self.uid = uid
    
    self.fullName = dictionary["fullName"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
    self.userName = dictionary["userName"] as? String ?? ""
    self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
  }
}
