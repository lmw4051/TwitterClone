//
//  TweetViewModel.swift
//  TwitterClone
//
//  Created by David on 2020/9/24.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

struct TweetViewModel {
  let tweet: Tweet
  let user: User
  
  var profileImageUrl: URL? {
    return tweet.user.profileImageUrl
  }
  
  var timeStamp: String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
    formatter.maximumUnitCount = 1
    formatter.unitsStyle = .abbreviated
    let now = Date()    
    return formatter.string(from: tweet.timeStamp, to: now) ?? "2m"
  }
  
  var userNameText: String {
    return "@\(user.userName)"
  }
  
  var headerTimeStamp: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a ・ MM/dd/yyyy"
    return formatter.string(from: tweet.timeStamp)
  }
  
  var reTweetsAttributedString: NSAttributedString? {
    return attributedText(withValue: tweet.reTweetCount, text: "ReTweets")
  }
  
  var likesAttributedString: NSAttributedString? {
    return attributedText(withValue: tweet.likes, text: "Likes")
  }
  
  var userInfoText: NSAttributedString {
    let title = NSMutableAttributedString(string: user.fullName,
                                          attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
    title.append(NSAttributedString(string: " @\(user.userName)",
      attributes: [.font: UIFont.systemFont(ofSize: 14),
                   .foregroundColor: UIColor.lightGray]))
    
    title.append(NSAttributedString(string: " ・ \(timeStamp)",
                                    attributes: [.font: UIFont.systemFont(ofSize: 14),
                                    .foregroundColor: UIColor.lightGray]))
    return title
  }
  
  init(tweet: Tweet) {
    self.tweet = tweet
    self.user = tweet.user
  }
  
  fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
    let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
    attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
    return attributedTitle
  }
  
  func size(forWidth width: CGFloat) -> CGSize {
    let measurementLabel = UILabel()
    measurementLabel.text = tweet.caption
    measurementLabel.numberOfLines = 0
    measurementLabel.lineBreakMode = .byWordWrapping
    measurementLabel.translatesAutoresizingMaskIntoConstraints = false
    measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true        
    return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
  }
}
