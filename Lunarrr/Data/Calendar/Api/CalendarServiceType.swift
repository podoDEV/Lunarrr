//
//  CalendarServiceType.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/23.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

typealias CalendarServiceResponse = (_ completion: Result<Bool, CalendarError>) -> Void
protocol CalendarServiceType {
  var type: CalendarProviderType { get }

  func addEvent(_ event: Event, completion : @escaping CalendarServiceResponse)
  func removeEvent(_ event: Event, completion: @escaping CalendarServiceResponse)
  func removeAllEvents()
  func authorization(completion: @escaping CalendarServiceResponse)
}
