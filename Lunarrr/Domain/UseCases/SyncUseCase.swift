//
//  SyncUseCase.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

class SyncUseCase: UseCase {

  let calendarDataSource: CalendarDataSource
  let settingsDataSource: SettingsDataSource

  init(
    calendarDataSource: CalendarDataSource,
    settingsDataSource: SettingsDataSource
  ) {
    self.calendarDataSource = calendarDataSource
    self.settingsDataSource = settingsDataSource
  }

  func currentSettings() -> Settings? {
    return settingsDataSource.current
  }

  func updateSync(
    type: CalendarProviderType,
    sync: Bool,
    completion: @escaping (Result<Bool, CalendarError>) -> Void
  ) {
    guard sync == true else {
      updateDataSource(type: type, sync: sync, completion: completion)
      return
    }
    calendarDataSource.authorization(type: type) { result in
      switch result {
      case .success:
        self.updateDataSource(type: type, sync: sync, completion: completion)
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

private extension SyncUseCase {
  func updateDataSource(
    type: CalendarProviderType,
    sync: Bool,
    completion: @escaping CalendarServiceResponse
  ) {
    let result = settingsDataSource.updateSync(type: type, sync: sync)
    if result {
      if sync {
        calendarDataSource.syncCalendar(type: type, completion: completion)
      } else {
        calendarDataSource.unsyncCalendar(type: type, completion: completion)
      }
    } else {
      completion(.failure(.calendarSyncFailedInLocal))
    }
  }
}
