//
//  AppDelegate.swift
//  Lunarrr
//
//  Created by hb1love on 2019/10/12.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  private var dependency: AppDependency!

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.dependency = self.dependency ?? ApplicationInjector.resolve()
    self.dependency.configureSDKs()
    self.dependency.configureAppearance()
    return true
  }
}

