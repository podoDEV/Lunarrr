//
//  CalendarDataSource.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

protocol CalendarDataSource {
  func events() -> [Event]
  func event(id: String) -> Event?
  func newEvent(event: Event, types: [CalendarProviderType], completion: (Result<Event, CalendarError>) -> Void)
  func updateEvent(event: Event, types: [CalendarProviderType], completion: (Result<Event, CalendarError>) -> Void)
  func deleteEvent(id: String, types: [CalendarProviderType], completion: CalendarServiceResponse)

  func authorization(type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
  func syncCalendar(type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
}

protocol CalendarLocalDataSource {
  func selectEvents() -> [RealmEvent]
  func selectEvent(id: String) -> RealmEvent?
  func insertEvent(event: RealmEvent, completion: (Result<RealmEvent, CalendarError>) -> Void)
  func updateEvent(event: RealmEvent, completion: (Result<RealmEvent, CalendarError>) -> Void)
  func deleteEvent(id: String, completion: (Result<Bool, CalendarError>) -> Void)
}

protocol CalendarRemoteDataSource {
  func insertEvents(events: [Event], type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
  func insertEvent(event: Event, types: [CalendarProviderType])
  func updateEvent(oldEvent: Event, newEvent: Event, types: [CalendarProviderType])
  func deleteEvent(event: Event, types: [CalendarProviderType])

  func authorization(type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
}
