//
//  SettingRepositoryType.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/27.
//  Copyright © 2019 podo. All rights reserved.
//

protocol SettingRepositoryType {
  var current: Settings? { get }
  func updateSync(type: CalendarProviderType, sync: Bool) -> Bool
}
