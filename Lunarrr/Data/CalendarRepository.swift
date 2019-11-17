//
//  CalendarRepository.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

final class CalendarRepository: CalendarDataSource {
  private let local: CalendarLocalDataSource
  private let remote: CalendarRemoteDataSource

  init(local: CalendarLocalDataSource, remote: CalendarRemoteDataSource) {
    self.local = local
    self.remote = remote
  }

  func events() -> [Event] {
    return local.selectEvents().map(Event.init)
  }

  func newEvent(event: Event) {
    local.insertEvent(event: event.convertForRealm())
  }

  func updateEvent(event: Event) {
    local.updateEvent(event: event.convertForRealm())
  }

  func deleteEvent(id: String) {
    local.deleteEvent(id: id)
  }

  func newSync(provider: CalendarProvider) {

  }

  func unsync(provider: CalendarProvider) {
    
  }
}
