//
//  CalendarRepositoryType.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/27.
//  Copyright © 2019 podo. All rights reserved.
//

protocol CalendarRepositoryType {
  func events(types: [CalendarProviderType]) -> [Event]
  func event(id: String) -> Event?
  func newEvent(event: Event, types: [CalendarProviderType], completion: (Result<Event, CalendarError>) -> Void)
  func updateEvent(event: Event, types: [CalendarProviderType], completion: (Result<Event, CalendarError>) -> Void)
  func deleteEvent(id: String, types: [CalendarProviderType], completion: CalendarServiceResponse)

  func authorization(type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
  func syncCalendar(type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
  func unsyncCalendar(type: CalendarProviderType, completion: @escaping CalendarServiceResponse)
}
