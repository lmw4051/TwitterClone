//
//  Notification.swift
//  TwitterClone
//
//  Created by David on 2020/9/27.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

enum NotificationType: Int {
  case follow
  case like
  case reply
  case reTweet
  case mention
}

struct Notification {
  let tweetID: String?
  var timeStamp: Date!
  let user: User
  var tweet: Tweet?
  var type: NotificationType!
  
  init(user: User, dictionary: [String: AnyObject]) {
    self.user = user    
    
    self.tweetID = dictionary["tweetID"] as? String ?? ""
    
    if let timeStamp = dictionary["timeStamp"] as? Double {
      self.timeStamp = Date(timeIntervalSince1970: timeStamp)
    }
    
    if let type = dictionary["type"] as? Int {
      self.type = NotificationType(rawValue: type)
    }
  }
}
