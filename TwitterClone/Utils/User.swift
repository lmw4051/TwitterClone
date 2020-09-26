//
//  User.swift
//  TwitterClone
//
//  Created by David on 2020/9/23.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation
import Firebase

struct User {
  let fullName: String
  let email: String
  let userName: String
  var profileImageUrl: URL?
  let uid: String
  var isFollowed = false
  var stats: UserRelationStats?
  
  var isCurrentUser: Bool {
    return Auth.auth().currentUser?.uid == uid
  }
  
  init(uid: String, dictionary: [String: AnyObject]) {
    self.uid = uid
    
    self.fullName = dictionary["fullName"] as? String ?? ""
    self.email = dictionary["email"] as? String ?? ""
    self.userName = dictionary["userName"] as? String ?? ""
    
    if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
      guard let url = URL(string: profileImageUrlString) else { return }
      self.profileImageUrl = url
    }
  }
}

struct UserRelationStats {
  var followers: Int
  var following: Int
}
