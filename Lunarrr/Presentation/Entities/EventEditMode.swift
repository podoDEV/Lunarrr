//
//  EventEditMode.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

enum EventEditMode: Equatable {
  case new
  case edit(Event)

  var modeTitle: String {
    switch self {
    case .new: return "일정 추가"
    case .edit: return "일정 편집"
    }
  }

  var eventTitle: String? {
    switch self {
    case .new: return ""
    case .edit(let event): return event.title
    }
  }

  var startDate: Date {
    switch self {
    case .new: return Date()
    case .edit(let event): return event.date ?? Date()
    }
  }
}
