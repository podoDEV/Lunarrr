//
//  CalendarRemoteDataSource.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

final class CalendarRemoteDataSource: CalendarRemoteDataSourceType {

  private var calServices: [CalendarServiceType]

  init(calServices: [CalendarServiceType]) {
    self.calServices = calServices
  }

  func insertEvents(
    events: [Event],
    type: CalendarProviderType,
    completion: @escaping CalendarServiceResponse
  ) {
    let service = self.findCalService(type: type)
    events.forEach { event in
      service.addEvent(event) { result in
        switch result {
        case .success:
          break
        case .failure(let error):
          completion(.failure(error))
          return
        }
      }
    }
    completion(.success(true))
  }

  func insertEvent(event: Event, types: [CalendarProviderType]) {
    for type in types {
      let service = self.findCalService(type: type)
      service.addEvent(event) { _ in }
    }
  }

  func updateEvent(oldEvent: Event, newEvent: Event, types: [CalendarProviderType]) {
    for type in types {
      let service = self.findCalService(type: type)
      service.removeEvent(oldEvent) { _ in }
      service.addEvent(newEvent) { _ in }
    }
  }

  func deleteEvent(event: Event, types: [CalendarProviderType]) {
    for type in types {
      let service = self.findCalService(type: type)
      service.removeEvent(event) { _ in }
    }
  }

  func deleteAllEvent(type: CalendarProviderType) {
    let service = self.findCalService(type: type)
    service.removeAllEvents()
  }

  func authorization(
    type: CalendarProviderType,
    completion: @escaping CalendarServiceResponse
  ) {
    let service = self.findCalService(type: type)
    service.authorization(completion: completion)
  }
}

private extension CalendarRemoteDataSource {
  func findCalService(type: CalendarProviderType) -> CalendarServiceType {
    guard let serivce = calServices.first(where: { $0.type == type }) else {
      fatalError("Failed to find calendar provider - \(type.title)")
    }
    return serivce
  }
}
