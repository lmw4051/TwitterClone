//
//  TweetService.swift
//  TwitterClone
//
//  Created by David on 2020/9/23.
//  Copyright © 2020 David. All rights reserved.
//

import Firebase

struct TweetService {
  static let shared = TweetService()
  
  func uploadTweet(caption: String, type: UploadTweetConfiguration, completion: @escaping (Error?, DatabaseReference) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let values = ["uid": uid,
                  "timeStamp": Int(NSDate().timeIntervalSince1970),
                  "likes": 0,
                  "reTweets": 0,
                  "caption": caption] as [String: Any]
    
    switch type {
    case .tweet:
      REF_TWEETS.childByAutoId().updateChildValues(values) { (err, ref) in
        // update user-tweet structure after tweet upload completes
        guard let tweetID = ref.key else { return }
        REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
      }
    case .reply(let tweet):
      REF_TWEET_REPLIES.child(tweet.tweetID).childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
  }
  
  func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
    var tweets = [Tweet]()
    
    REF_TWEETS.observe(.childAdded) { snapshot in
      guard let dictionary = snapshot.value as? [String: Any] else { return }
      guard let uid = dictionary["uid"] as? String else { return }
      let tweetID = snapshot.key
      
      print(dictionary)
      
      UserService.shared.fetchUser(uid: uid) { user in
        let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)        
        tweets.append(tweet)
        completion(tweets)
      }
    }
  }
  
  func fetchTweets(forUser user: User, completion: @escaping ([Tweet]) -> Void) {
    var tweets = [Tweet]()
    REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
      let tweetID = snapshot.key
      
      REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
        guard let dictionary = snapshot.value as? [String: Any] else { return }
        guard let uid = dictionary["uid"] as? String else { return }
        
        UserService.shared.fetchUser(uid: uid) { user in
          let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
          tweets.append(tweet)
          completion(tweets)
        }
      }
    }
  }
}
