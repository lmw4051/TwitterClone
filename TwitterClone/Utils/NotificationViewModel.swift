//
//  NotificationViewModel.swift
//  TwitterClone
//
//  Created by David on 2020/9/28.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

struct NotificationViewModel {
  private let notification: Notification
  private let type: NotificationType
  private let user: User
  
  var timeStampString: String? {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
    formatter.maximumUnitCount = 1
    formatter.unitsStyle = .abbreviated
    let now = Date()
    return formatter.string(from: notification.timeStamp, to: now) ?? "2m"
  }
  
  var notificationMessage: String {
    switch type {
    case .follow: return " started following you"
    case .like: return " liked your tweet"
    case .reply: return " replied to your tweet"
    case .reTweet: return " reTweeted your tweet"
    case .mention: return " mentioned you in a tweet"
    }
  }
  
  var notificationText: NSAttributedString? {
    guard let timeStamp = timeStampString else { return nil }
    
    let attributedText = NSMutableAttributedString(string: user.userName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
    attributedText.append(NSAttributedString(string: notificationMessage, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
    attributedText.append(NSAttributedString(string: " \(timeStamp)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
    return attributedText
  }
  
  var profileImageUrl: URL? {
    return user.profileImageUrl
  }
  
  init(notification: Notification) {
    self.notification = notification
    self.type = notification.type
    self.user = notification.user
  }
}
