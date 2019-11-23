//
//  Settings.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

class Settings: NSObject, NSCoding, NSCopying {

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

class CalendarProvider: NSObject, NSCoding {

  var providerType: CalendarProviderType?
  var sync: Bool?

  init(type: CalendarProviderType, sync: Bool = false) {
    self.providerType = type
    self.sync = sync
  }

  required init?(coder: NSCoder) {
    let providerTypeRaw = coder.decodeObject(forKey: "providerType") as! String
    self.providerType = CalendarProviderType(rawValue: providerTypeRaw)
    self.sync = coder.decodeObject(forKey: "sync") as? Bool
  }

  func encode(with coder: NSCoder) {
    coder.encode(self.providerType?.rawValue, forKey: "providerType")
    coder.encode(self.sync, forKey: "sync")
  }
}
