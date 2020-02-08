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
  case event_create(Event)
  case event_edit
  case event_delete

  case eventlist_view
  case create_view
  case edit_view(Event)
  case setting_view
}

extension AnalyticsEvent: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
    case .event_create: return "일정_생성"
    case .event_edit: return "일정_편집"
    case .event_delete: return "일정_삭제"

    case .eventlist_view: return "일정_리스트_화면"
    case .create_view: return "일정_생성_화면"
    case .edit_view: return "일정_편집_화면"
    case .setting_view:return "설정_화면"
    }
  }

  func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case .event_create(let event),
         .edit_view(let event):
      return [
        "title": event.title ?? "",
        "date": event.date?.description ?? ""
      ]
    default:
      return nil
    }
  }
}

