//
//  CalendarLocalRepository.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

final class CalendarLocalRepository: CalendarLocalDataSource {
  private var database: CalendarDatabase

  init(database: CalendarDatabase) {
    self.database = database
  }

  func selectEvents() -> [RealmEvent] {
    return database.events()
  }

  func insertEvent(event: RealmEvent) {
    database.create(event: event)
  }

  func updateEvent(event: RealmEvent) {
    database.create(event: event)
  }

  func deleteEvent(id: String) {
    database.delete(id: id)
  }
}
