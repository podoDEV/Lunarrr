//
//  EventsUseCase.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

class EventsUseCase: UseCase {

  let calendarDataSource: CalendarDataSource
  let settingsDataSource: SettingsDataSource

  init(
    calendarDataSource: CalendarDataSource,
    settingsDataSource: SettingsDataSource
  ) {
    self.calendarDataSource = calendarDataSource
    self.settingsDataSource = settingsDataSource
  }

  func getAll() -> [Event] {
    return calendarDataSource.events()
  }

  func new(_ event: Event) {
    let providers = settingsDataSource.current?.providers ?? []
    let types = providers
      .filter { $0.sync == true }
      .map { $0.providerType! }
    calendarDataSource.newEvent(event: event, types: types) { _ in
//      switch result {
//      case .success(let event):
//        log.debug("")
//      case .failure(let error):
//        log.debug("")
//      }
    }
  }

  func update(_ event: Event) {
    let providers = settingsDataSource.current?.providers ?? []
    let types = providers
      .filter { $0.sync == true }
      .map { $0.providerType! }
    calendarDataSource.updateEvent(event: event, types: types) { _ in
//      switch result {
//      case .success(let event):
//        log.debug("")
//      case .failure(let error):
//        log.debug("")
//      }
    }
  }

  func delete(_ id: String) {
    let providers = settingsDataSource.current?.providers ?? []
    let types = providers
      .filter { $0.sync == true }
      .map { $0.providerType! }
    calendarDataSource.deleteEvent(id: id, types: types) { _ in }
  }
}
