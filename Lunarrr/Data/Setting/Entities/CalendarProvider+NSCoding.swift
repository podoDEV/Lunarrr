//
//  CalendarProvider+NSCoding.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/27.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

extension CalendarProvider: NSCoding {
  func encode(with coder: NSCoder) {
    coder.encode(self.providerType?.rawValue, forKey: "providerType")
    coder.encode(self.sync, forKey: "sync")
  }
}
