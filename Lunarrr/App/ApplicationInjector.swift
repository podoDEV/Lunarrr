//
//  ApplicationInjector.swift
//  Lunarrr
//
//  Created by hb1love on 2019/10/19.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import Firebase
import SwiftyBeaver
import Umbrella

struct AppDependency {
  let window: UIWindow
  let coordinator: ApplicationCoordinator
  let configureSDKs: () -> Void
  let configureAppearance: () -> Void
}

struct ApplicationInjector {
  static func resolve() -> AppDependency {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let rootController = UINavigationController()
    window.rootViewController = rootController
    window.backgroundColor = .white
    window.makeKeyAndVisible()

    let coordinator = ApplicationCoordinator(window: window)
    return AppDependency(
      window: window,
      coordinator: coordinator,
      configureSDKs: configureSDKs,
      configureAppearance: configureAppearance
    )
  }

  static func configureSDKs() {
    configureLogger()
    configureAnalytics()
  }

  static func configureLogger() {
    let console = ConsoleDestination()
    log.addDestination(console)
  }

  static func configureAnalytics() {
    FirebaseApp.configure()
    analytics.register(provider: FirebaseProvider())
  }

  static func configureAppearance() {
    UINavigationBar.appearance().shadowImage = UIImage()
  }
}
