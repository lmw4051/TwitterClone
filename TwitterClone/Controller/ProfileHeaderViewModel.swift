//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by David on 2020/9/25.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

enum ProfileFilterOptions: Int, CaseIterable {
  case tweets
  case replies
  case likes
  
  var description: String {
    switch self {
    case .tweets: return "Tweets"
    case .replies: return "Tweets & Replies"
    case .likes: return "Likes"
    }
  }
}
