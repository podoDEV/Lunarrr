//
//  AnalyticsEvent.swift
//  Lunarrr
//
//  Created by hb1love on 2019/10/26.
//  Copyright © 2019 podo. All rights reserved.
//

import Firebase
import Umbrella

typealias LunarrrAnalytics = Umbrella.Analytics<AnalyticsEvent>
let analytics = LunarrrAnalytics()

enum AnalyticsEvent {
  case eventlist_view
  case create_view
  case edit_view(Event)
  case setting_view
}

extension AnalyticsEvent: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
    case .eventlist_view: return "eventlist_view"
    case .create_view: return "create_view"
    case .edit_view: return "edit_view"
    case .setting_view:return "setting_view"
    }
  }

  func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case .edit_view(let event):
      return [
        "title": event.title ?? "",
        "date": event.date?.description ?? ""
      ]
    default:
      return nil
    }
  }
}

