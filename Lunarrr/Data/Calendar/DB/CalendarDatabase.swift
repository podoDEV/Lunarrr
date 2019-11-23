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
    self.realm = try! Realm()
  }

  func events() -> [RealmEvent] {
    let events = realm.objects(RealmEvent.self)
    return events.filter { _ in true }
  }

  func event(id: String) -> RealmEvent? {
    return realm.object(ofType: RealmEvent.self, forPrimaryKey: id)
  }

  func create(event: RealmEvent, completion: (Result<RealmEvent, CalendarError>) -> Void) {
    do {
      try realm.write {
        let realmEvent = realm.create(RealmEvent.self, value: event, update: .all)
        completion(.success(realmEvent))
      }
    } catch {
      completion(.failure(.eventNotAddedToCalendar))
    }
  }

  func delete(id: String, completion: (Result<Bool, CalendarError>) -> Void) {
    do {
      try realm.write {
        guard
          let event = realm.object(ofType: RealmEvent.self, forPrimaryKey: id)
          else {
            log.error("eventNotRemovedFromCalendar")
            completion(.failure(.eventNotRemovedFromCalendar))
            return
        }
        realm.delete(event)
        log.info("eventRemoved")
        completion(.success(true))
      }
    } catch {
      log.error("eventNotRemovedFromCalendar")
      completion(.failure(.eventNotRemovedFromCalendar))
    }
  }

  func exist(dbEvent: RealmEvent) -> Bool {
    let event = realm
      .objects(RealmEvent.self)
      .filter("title = '\(dbEvent.title)' AND date = '\(dbEvent.date)'")
    return event.isEmpty == false
  }
}
