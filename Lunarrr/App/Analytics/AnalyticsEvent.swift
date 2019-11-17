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
  case main_view
  case create_view

  case viewNote(noteID: Int)
}

extension AnalyticsEvent: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
    case .main_view: return "main_view"
    case .create_view: return "create_view"

    case .viewNote:return "view_note"
    }
  }

  func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case .viewNote(let noteID):
      return [
        "note_id": noteID
      ]
    default:
      return nil
    }
  }
}

