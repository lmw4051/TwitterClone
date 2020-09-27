//
//  ActionSheetLauncher.swift
//  TwitterClone
//
//  Created by David on 2020/9/27.
//  Copyright © 2020 David. All rights reserved.
//

import Foundation

class ActionSheetLauncher: NSObject {
  // MARK: - Properties
  private let user: User
  
  init(user: User) {
    self.user = user
    super.init()
  }
  
  // MARK: - Helpers
  func show() {
    print("Show action sheet for user \(user.userName)")
  }
}
