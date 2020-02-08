//
//  CalendarError.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

enum CalendarError: Error {
  case calendarSyncFailedInLocal
  case calendarRetrieveFailed

  case eventNotExistsInCalendar
  case eventNotAddedToCalendar
  case eventNotRemovedFromCalendar
  case eventRemoveFailed
  case eventAlreadyExistsInCalendar
  case calendarAccessDeniedOrRestricted
}
