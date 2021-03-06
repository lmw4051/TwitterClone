//
//  TweetHeader.swift
//  TwitterClone
//
//  Created by David on 2020/9/26.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit
import ActiveLabel

protocol TweetHeaderDelegate: class {
  func showActionSheet()
  func handleFetchUser(withUserName userName: String)
}

class TweetHeader: UICollectionReusableView {
  // MARK: - Properties
  var tweet: Tweet? {
    didSet {
      configure()
    }
  }
  
  weak var delegate: TweetHeaderDelegate?
  
  private lazy var profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.clipsToBounds = true
    iv.setDimensions(width: 48, height: 48)
    iv.layer.cornerRadius = 48 / 2
    iv.backgroundColor = .twitterBlue
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
    iv.addGestureRecognizer(tap)
    iv.isUserInteractionEnabled = true
    return iv
  }()
  
  private let fullNameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 14)
    return label
  }()
  
  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 14)
    label.textColor = .lightGray
    return label
  }()
  
  private let captionLabel: ActiveLabel = {
    let label = ActiveLabel()
    label.font = .systemFont(ofSize: 20)
    label.numberOfLines = 0
    label.mentionColor = .twitterBlue
    label.hashtagColor = .twitterBlue
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 14)
    label.textAlignment = .left
    return label
  }()
  
  private lazy var optionsButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .lightGray
    button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
    button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
    return button
  }()
  
  private let replyLabel: ActiveLabel = {
    let label = ActiveLabel()
    label.textColor = .lightGray
    label.font = .systemFont(ofSize: 12)
    label.mentionColor = .twitterBlue
    return label
  }()
  
  private lazy var reTweetsLabel = UILabel()
  private lazy var likesLabel = UILabel()
  
  private lazy var statsView: UIView = {
    let view = UIView()    
    
    let divider1 = UIView()
    divider1.backgroundColor = .systemGroupedBackground
    view.addSubview(divider1)
    divider1.anchor(top: view.topAnchor,
                    left: view.leftAnchor,
                    right: view.rightAnchor,
                    paddingLeft: 8,
                    height: 1.0)
    
    let stack = UIStackView(arrangedSubviews: [reTweetsLabel, likesLabel])
    stack.axis = .horizontal
    stack.spacing = 12
    
    view.addSubview(stack)
    stack.centerY(inView: view)
    stack.anchor(left: view.leftAnchor,
                 paddingLeft: 16)
    
    let divider2 = UIView()
    divider2.backgroundColor = .systemGroupedBackground
    view.addSubview(divider2)
    divider2.anchor(left: view.leftAnchor,
                    bottom: view.bottomAnchor,
                    right: view.rightAnchor,
                    paddingLeft: 8,
                    height: 1.0)
    return view
  }()
  
  private lazy var commentButton: UIButton = {
    let button = createButton(withImageName: "comment")
    button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var reTweetButton: UIButton = {
    let button = createButton(withImageName: "retweet")
    button.addTarget(self, action: #selector(handleReTweetTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var likeButton: UIButton = {
    let button = createButton(withImageName: "like")
    button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var shareButton: UIButton = {
    let button = createButton(withImageName: "share")
    button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let labelStack = UIStackView(arrangedSubviews: [fullNameLabel, userNameLabel])
    labelStack.axis = .vertical
    labelStack.spacing = -6
    
    let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
    imageCaptionStack.spacing = 12
    
    let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
    stack.axis = .vertical
    stack.spacing = 8
    stack.distribution = .fillProportionally
    
    addSubview(stack)
    stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor,
    paddingTop: 4, paddingLeft: 12, paddingRight: 12)
    
    addSubview(stack)
    stack.anchor(top: topAnchor,
                 left: leftAnchor,
                 paddingTop: 16,
                 paddingLeft: 16)
    
    addSubview(captionLabel)
    captionLabel.anchor(top: stack.bottomAnchor,
                        left: leftAnchor,
                        right: rightAnchor,
                        paddingTop: 12,
                        paddingLeft: 16,
                        paddingRight: 16)
    
    addSubview(dateLabel)
    dateLabel.anchor(top: captionLabel.bottomAnchor,
                     left: leftAnchor,
                     paddingTop: 12,
                     paddingLeft: 16)
    
    addSubview(optionsButton)
    optionsButton.centerY(inView: stack)
    optionsButton.anchor(right: rightAnchor, paddingRight: 8)
    
    addSubview(statsView)
    statsView.anchor(top: dateLabel.bottomAnchor,
                     left: leftAnchor,
                     right: rightAnchor,
                     paddingTop: 20,
                     height: 40)
    
    let actionStack = UIStackView(arrangedSubviews: [commentButton,
                                                     reTweetButton,
                                                     likeButton,
                                                     shareButton])
    actionStack.spacing = 72
    actionStack.distribution = .fillEqually
    
    addSubview(actionStack)
    actionStack.centerX(inView: self)
    actionStack.anchor(top: statsView.bottomAnchor,
                       paddingTop: 16)
    
    configureMentionHandler()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Selectors
  @objc func handleProfileImageTapped() {
    print("handleProfileImageTapped")
  }
  
  @objc func showActionSheet() {
    delegate?.showActionSheet()
  }
  
  @objc func handleCommentTapped() {
   
  }
  
  @objc func handleReTweetTapped() {
   
  }
  
  @objc func handleLikeTapped() {
   
  }
  
  @objc func handleShareTapped() {
   
  }
  
  // MARK: - Helpers
  func configure() {
    guard let tweet = tweet else { return }
    let viewModel = TweetViewModel(tweet: tweet)
    captionLabel.text = tweet.caption
    fullNameLabel.text = tweet.user.fullName
    userNameLabel.text = viewModel.userNameText
    profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    dateLabel.text = viewModel.headerTimeStamp
    reTweetsLabel.attributedText = viewModel.reTweetsAttributedString
    
    likesLabel.attributedText = viewModel.likesAttributedString
    likeButton.setImage(viewModel.likeButtonImage, for: .normal)
    likeButton.tintColor = viewModel.likeButtonTintColor
    
    replyLabel.isHidden = viewModel.shouldHideReplyLabel
    replyLabel.text = viewModel.replyText
  }
  
  func createButton(withImageName imageName: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: imageName), for: .normal)
    button.tintColor = .darkGray
    button.setDimensions(width: 20, height: 20)
    return button
  }
  
  func configureMentionHandler() {
    captionLabel.handleMentionTap { userName in
      self.delegate?.handleFetchUser(withUserName: userName)
    }
  }
}
