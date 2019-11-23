//
//  RealmEvent.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class RealmEvent: Object {
  dynamic var id: String = UUID().uuidString
  dynamic var title: String = ""
  dynamic var date: Date = Date()

  override static func primaryKey() -> String {
    return "id"
  }
}
