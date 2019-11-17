//
//  CalendarDataSource.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

protocol CalendarDataSource {
  func events() -> [Event]
  func newEvent(event: Event)
  func updateEvent(event: Event)
  func deleteEvent(id: String)
  func newSync(provider: CalendarProvider)
  func unsync(provider: CalendarProvider)
}

protocol CalendarLocalDataSource {
  func selectEvents() -> [RealmEvent]
  func insertEvent(event: RealmEvent)
  func updateEvent(event: RealmEvent)
  func deleteEvent(id: String)
}

protocol CalendarRemoteDataSource {

}
