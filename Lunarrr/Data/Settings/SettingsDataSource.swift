//
//  SettingsDataSource.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

protocol SettingsDataSource {
  var current: Settings? { get }
  func updateSync(type: CalendarProviderType, sync: Bool) -> Bool
}
