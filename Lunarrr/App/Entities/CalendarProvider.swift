//
//  CalendarProvider.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

enum CalendarProvider: String {
  case apple
  case google

  var title: String {
    switch self {
    case .apple: return "Apple Calendar"
    case .google: return "Google Calendar"
    }
  }
}
