//
//  CalendarDatabase.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

import RealmSwift

final class CalendarDatabase {
  private let realm: Realm

  init() {
    let config = Realm.Configuration(
        fileURL: Bundle.main.url(forResource: "com.podo.lunarrr", withExtension: "realm")
    )

//    self.realm = try! Realm(configuration: config)
    self.realm = try! Realm()
  }

  func events() -> [RealmEvent] {
    let events = realm.objects(RealmEvent.self)
    return events.filter { _ in true }
  }

  func create(event: RealmEvent) {
    try! realm.write {
      realm.add(event, update: .all)
    }
  }

  func delete(id: String) {
    try! realm.write {
      realm.delete(realm.objects(RealmEvent.self).filter("id=%@", id))
    }
  }

  func exist(dbEvent: RealmEvent) -> Bool {
    let event = realm
      .objects(RealmEvent.self)
      .filter("title = '\(dbEvent.title)' AND date = '\(dbEvent.date)'")
    return event.isEmpty == false
  }
}
