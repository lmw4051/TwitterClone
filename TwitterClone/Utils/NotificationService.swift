//
//  NotificationService.swift
//  TwitterClone
//
//  Created by David on 2020/9/28.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation
import Firebase

struct NotificationService {
  static let shared = NotificationService()
  
  func uploadNotification(type: NotificationType, tweet: Tweet? = nil) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    var values: [String: Any] = ["timeStamp": Int(NSDate().timeIntervalSince1970),
                                 "uid": uid,
                                 "type": type.rawValue]
    
    if let tweet = tweet {
      values["tweetID"] = tweet.tweetID
      REF_NOTIFICATIONS.child(tweet.user.uid).childByAutoId().updateChildValues(values)
    } else {
      
    }
  }
}
