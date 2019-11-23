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
    return local.selectEvents().map(Event.init).sorted(by: <)
  }

  func event(id: String) -> Event? {
    if let dbEvent = local.selectEvent(id: id) {
      return Event(event: dbEvent)
    }
    return nil
  }

  func newEvent(
    event: Event,
    types: [CalendarProviderType],
    completion: (Result<Event, CalendarError>) -> Void
  ) {
    local.insertEvent(event: event.convertForRealm()) { result in
      switch result {
      case .success(let dbEvent):
        let newEvent = Event(event: dbEvent).convertForRemote()
        remote.insertEvent(event: newEvent, types: types)
        completion(.success(newEvent))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func updateEvent(
    event: Event,
    types: [CalendarProviderType],
    completion: (Result<Event, CalendarError>) -> Void
  ) {
    guard let id = event.id,
      let oldDBEvent = local.selectEvent(id: id) else {
        completion(.failure(.eventNotExistsInCalendar))
        return
    }
    let oldEvent = Event(event: oldDBEvent).convertForRemote()
    local.updateEvent(event: event.convertForRealm()) { result in
      switch result {
      case .success(let newDBEvent):
//        remote.deleteEvent(event: oldEvent, types: types)

        let newEvent = Event(event: newDBEvent).convertForRemote()

        remote.updateEvent(oldEvent: oldEvent, newEvent: newEvent, types: types)
//        remote.updateEvent(event: newEvent, types: types)
        completion(.success(newEvent))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func deleteEvent(
    id: String,
    types: [CalendarProviderType],
    completion: CalendarServiceResponse
  ) {
    guard let dbEvent = local.selectEvent(id: id) else {
      completion(.failure(.eventNotExistsInCalendar))
      return
    }
    let eventForRemove = Event(event: dbEvent).convertForRemote()
    local.deleteEvent(id: id) { result in
      switch result {
      case .success:
        remote.deleteEvent(event: eventForRemove, types: types)
        completion(.success(true))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  func authorization(type: CalendarProviderType, completion: @escaping CalendarServiceResponse) {
    remote.authorization(type: type, completion: completion)
  }

  func syncCalendar(type: CalendarProviderType, completion: @escaping CalendarServiceResponse) {
    let events = local.selectEvents().map(Event.init)
    remote.insertEvents(events: events, type: type, completion: completion)
  }

  func unsyncCalendar(type: CalendarProviderType, completion: @escaping CalendarServiceResponse) {

  }
}
