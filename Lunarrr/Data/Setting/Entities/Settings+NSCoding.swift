//
//  Settings.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

extension Settings: NSCoding, NSCopying {
  func encode(with coder: NSCoder) {
    coder.encode(self.providers, forKey: "providers")
  }

  func copy(with zone: NSZone? = nil) -> Any {
    return Settings(providers: self.providers ?? [])
  }

  static var `default`: Settings {
    var providers: [CalendarProvider] = []
    CalendarProviderType.allCases.forEach { type in
      providers.append(CalendarProvider(type: type))
    }
    return Settings(providers: providers)
  }
}
