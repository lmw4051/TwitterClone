//
//  UserService.swift
//  TwitterClone
//
//  Created by David on 2020/9/23.
//  Copyright © 2020 David. All rights reserved.
//

import Firebase

struct UserService {
  static let shared = UserService()
  
  func fetchUser() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
      guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
      let user = User(uid: uid, dictionary: dictionary)
      
      print("DEBUG: UserName is \(user.userName)")
      print("DEBUG: FullName is \(user.fullName)")
    }
  }
}
