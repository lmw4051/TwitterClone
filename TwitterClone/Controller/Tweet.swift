//
//  Tweet.swift
//  TwitterClone
//
//  Created by David on 2020/9/23.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

struct Tweet {
  let tweetID: String
  let caption: String
  let uid: String
  let likes: Int
  let reTweetCount: Int
  var timeStamp: Date!
  let user: User
  
  init(user: User, tweetID: String, dictionary: [String: Any]) {
    self.tweetID = tweetID
    self.user = user
    
    self.caption = dictionary["caption"] as? String ?? ""
    self.uid = dictionary["uid"] as? String ?? ""
    self.likes = dictionary["likes"] as? Int ?? 0
    self.reTweetCount = dictionary["reTweetCount"] as? Int ?? 0
    
    if let timeStamp = dictionary["timeStamp"] as? Double {
      self.timeStamp = Date(timeIntervalSince1970: timeStamp)
    }
  }  
}