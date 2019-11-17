//
//  CalendarService.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

import EventKit

protocol CalendarServiceType {
  func addEvent(_ event: Event)
}

class CalendarService: CalendarServiceType {
  init() {

  }

  func addEvent(_ event: Event) {
    
  }
}

func insertEvent(store: EKEventStore) {
    // 1
    let calendars = store.calendars(for: .event)

    for calendar in calendars {
        // 2
        if calendar.title == "ioscreator" {
            // 3
            let startDate = Date()
            // 2 hours
            let endDate = startDate.addingTimeInterval(2 * 60 * 60)

            // 4
            let event = EKEvent(eventStore: store)
            event.calendar = calendar

            event.title = "New Meeting"
            event.startDate = startDate
            event.endDate = endDate

            // 5
            do {
                try store.save(event, span: .thisEvent)
            }
            catch {
               print("Error saving event in calendar")             }
            }
    }
}
