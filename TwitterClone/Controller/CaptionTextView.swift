//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by David on 2020/9/23.
//  Copyright © 2020 David. All rights reserved.
//

import UIKit

class CaptionTextView: UITextView {
  // MARK: - Properties
  let placeholderLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.textColor = .darkGray
    label.text = "What's happening?"
    return label
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    backgroundColor = .white
    font = .systemFont(ofSize: 16)
    isScrollEnabled = false
    heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    addSubview(placeholderLabel)
    placeholderLabel.anchor(top: topAnchor,
                            left: leftAnchor,
                            paddingTop: 8,
                            paddingLeft: 4)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Selectors
  @objc func handleTextInputChange() {
    placeholderLabel.isHidden = !text.isEmpty
  }
}
