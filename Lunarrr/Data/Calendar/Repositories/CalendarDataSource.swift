//
//  CalendarDataSource.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

protocol CalendarLocalDataSourceType {
  func selectEvents() -> [RealmEvent]
  func selectEvent(id: String) -> RealmEvent?
  func insertEvent(event: RealmEvent, completion: (Result<RealmEvent, CalendarError>) -> Void)
  func updateEvent(event: RealmEvent, completion: (Result<RealmEvent, CalendarError>) -> Void)
  func deleteEvent(id: String, completion: CalendarServiceResponse)
}

protocol CalendarRemoteDataSourceType {
  func insertEvents(events: [Event], type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
  func insertEvent(event: Event, types: [CalendarProviderType])
  func updateEvent(oldEvent: Event, newEvent: Event, types: [CalendarProviderType])
  func deleteEvent(event: Event, types: [CalendarProviderType])
  func deleteAllEvent(type: CalendarProviderType)
  func authorization(type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
}
