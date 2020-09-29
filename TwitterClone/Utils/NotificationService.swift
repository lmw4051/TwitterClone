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
  
  func uploadNotification(toUser user: User,
                          type: NotificationType,
                          tweetID: String? = nil) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    var values: [String: Any] = ["timeStamp": Int(NSDate().timeIntervalSince1970),
                                 "uid": uid,
                                 "type": type.rawValue]
    
    if let tweetID = tweetID {
      values["tweetID"] = tweetID
    }
    
    REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
  }
  
  fileprivate func getNotifications(uid: String, completion: @escaping ([Notification]) -> Void) {
    var notifications = [Notification]()
    
    REF_NOTIFICATIONS.child(uid).observe(.childAdded) { snapshot in
      guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
      guard let uid = dictionary["uid"] as? String else { return }
      
      UserService.shared.fetchUser(uid: uid) { user in
        let notification = Notification(user: user, dictionary: dictionary)
        notifications.append(notification)
        completion(notifications)
      }
    }
  }
  
  func fetchNotifications(completion: @escaping ([Notification]) -> Void) {
    let notifications = [Notification]()
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    // Check whether notification exsits for user
    REF_NOTIFICATIONS.child(uid).observeSingleEvent(of: .value) { snapshot in
      if !snapshot.exists() {
        // No notifications for user
        completion(notifications)
      } else {
        self.getNotifications(uid: uid, completion: completion)
      }
    }
  }
}
