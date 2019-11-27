//
//  Settings.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/27.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

class Settings: NSObject {

  var providers: [CalendarProvider]?

  init(providers: [CalendarProvider]) {
    self.providers = providers
  }

  required init?(coder: NSCoder) {
    guard let providers = coder.decodeObject(forKey: "providers") as? [CalendarProvider] else {
      return nil
    }
    self.providers = providers
  }
}
