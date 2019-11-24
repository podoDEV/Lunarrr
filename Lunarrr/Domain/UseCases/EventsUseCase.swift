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
    return calendarDataSource.events(types: synchronizedProviders())
  }

  func new(_ event: Event) {
    calendarDataSource.newEvent(event: event, types: synchronizedProviders()) { result in
      switch result {
      case .success:
        log.info("Successfully created the event!")
      case .failure(let error):
        log.error("Failed to make a new event with error - \(error.localizedDescription)")
      }
    }
  }

  func update(_ event: Event) {
    calendarDataSource.updateEvent(event: event, types: synchronizedProviders()) { result in
      switch result {
      case .success:
        log.info("Successfully updated the event!")
      case .failure(let error):
        log.error("Failed to update the event with error - \(error.localizedDescription)")
      }
    }
  }

  func delete(_ id: String) {
    calendarDataSource.deleteEvent(id: id, types: synchronizedProviders()) { result in
      switch result {
      case .success:
        log.info("Successfully deleted the event!")
      case .failure(let error):
        log.error("Failed to delete the event with error - \(error.localizedDescription)")
      }
    }
  }
}

private extension EventsUseCase {
  func synchronizedProviders() -> [CalendarProviderType] {
    return (settingsDataSource.current?.providers ?? [])
      .filter { $0.sync == true }
      .map { $0.providerType! }
  }
}
