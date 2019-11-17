//
//  ApplicationCoordinator.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/18.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class ApplicationCoordinator {
  private let window: UIWindow
  private let navigator: Navigator

  init(window: UIWindow) {
    self.window = window
    self.navigator = Navigator(
      window: window
    )
  }

  func start() {
    navigator.show(.eventList, transition: .root)
  }
}
