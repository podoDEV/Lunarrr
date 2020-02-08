//
//  EventUseCase.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

class EventUseCase: UseCase {

  let calendarRepository: CalendarRepositoryType
  let settingRepository: SettingRepositoryType

  init(
    calendarRepository: CalendarRepositoryType,
    settingRepository: SettingRepositoryType
  ) {
    self.calendarRepository = calendarRepository
    self.settingRepository = settingRepository
  }

  func getAll() -> [Event] {
    return calendarRepository.events(types: synchronizedProviders())
  }

  func new(_ event: Event) {
    calendarRepository.newEvent(event: event, types: synchronizedProviders()) { result in
      switch result {
      case .success:
        log.info("Successfully created the event!")
      case .failure(let error):
        log.error("Failed to make a new event with error - \(error.localizedDescription)")
      }
    }
  }

  func update(_ event: Event) {
    calendarRepository.updateEvent(event: event, types: synchronizedProviders()) { result in
      switch result {
      case .success:
        log.info("Successfully updated the event!")
      case .failure(let error):
        log.error("Failed to update the event with error - \(error.localizedDescription)")
      }
    }
  }

  func delete(_ id: String) {
    calendarRepository.deleteEvent(id: id, types: synchronizedProviders()) { result in
      switch result {
      case .success:
        log.info("Successfully deleted the event!")
      case .failure(let error):
        log.error("Failed to delete the event with error - \(error.localizedDescription)")
      }
    }
  }
}

private extension EventUseCase {
  func synchronizedProviders() -> [CalendarProviderType] {
    return (settingRepository.current?.providers ?? [])
      .filter { $0.sync == true }
      .map { $0.providerType! }
  }
}
