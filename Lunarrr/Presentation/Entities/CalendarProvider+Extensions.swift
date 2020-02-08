//
//  CalendarProvider+Extensions.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

extension CalendarProviderType {
  var title: String {
    switch self {
    case .apple: return "Apple Calendar"
    case .google: return "Google Calendar"
    }
  }
}
