//
//  Event.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/09.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

class Event: Equatable {
  var title: String?
  var date: Date?

  var stringForSolar: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M월 d일"
    dateFormatter.locale = .current
    dateFormatter.calendar = Calendar(identifier: .gregorian)

    guard let date = self.date else { return "" }
    return dateFormatter.string(from: date)
  }

  init(title: String, date: Date) {
    self.title = title
    self.date = date
  }

  static func == (lhs: Event, rhs: Event) -> Bool {
    return lhs.title == rhs.title
      && lhs.date == rhs.date
  }
}
