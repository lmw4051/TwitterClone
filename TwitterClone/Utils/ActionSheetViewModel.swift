//
//  ActionSheetViewModel.swift
//  TwitterClone
//
//  Created by David on 2020/9/27.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

struct ActionSheetViewModel {
  private let user: User
  
  var options: [ActionSheetOptions] {
    var results = [ActionSheetOptions]()
    
    if user.isCurrentUser {
      results.append(.delete)
    } else {
      let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
      results.append(followOption)
    }
    
    results.append(.report)
    
    return results
  }
  
  init(user: User) {
    self.user = user
  }
}

enum ActionSheetOptions {
  case follow(User)
  case unfollow(User)
  case report
  case delete
  
  var description: String {
    switch self {
    case .follow(let user): return "Follow @\(user.userName)"
    case .unfollow(let user): return "Unfollow @\(user.userName)"
    case .report: return "Report Tweet"
    case .delete: return "Delete Tweet"
    }
  }
}
