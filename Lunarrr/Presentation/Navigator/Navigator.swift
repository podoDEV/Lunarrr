//
//  Navigator.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/18.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol Navigatable {
  var navigator: Navigator? { get set }
}

enum TransitionType {
  case root
  case push
  case present
}

enum ViewType {
  case launch
  case eventList
  case eventEdit(mode: EventEditMode, completion: (() -> Void))
  case setting

  func instantiateViewController() -> UIViewController & Navigatable {
    switch self {
    case .launch:
      return makeLaunchViewController()
    case .eventList:
      return makeEventListViewController()
    case .eventEdit(let mode, let completion):
      return makeEventEditViewController(mode: mode, completion: completion)
    case .setting:
      return makeSettingViewController()
    }
  }
}

extension ViewType {

  private func makeLaunchViewController() -> LaunchViewController {
    let vc = LaunchViewController()//.controllerFromStoryboard("EventList")
//    vc.eventUseCase = type(of: self).eventUseCase
    return vc
  }

  private func makeEventListViewController() -> EventListViewController {
    let vc = EventListViewController.controllerFromStoryboard("EventList")
    vc.eventUseCase = type(of: self).eventUseCase
    return vc
  }

  private func makeEventEditViewController(mode: EventEditMode, completion: @escaping (() -> Void)) -> EventEditViewController {
    let vc = EventEditViewController.controllerFromStoryboard("EventEdit")
    vc.eventUseCase = type(of: self).eventUseCase
    vc.didEditFinish = completion
    vc.mode = mode
    return vc
  }

  private func makeSettingViewController() -> SettingViewController {
    let vc = SettingViewController.controllerFromStoryboard("Setting")
    vc.syncUseCase = type(of: self).syncUseCase
    return vc
  }

}

extension ViewType {

  static let eventUseCase: EventUseCase = {
    return EventUseCase(
      calendarRepository: calendarRepository,
      settingRepository: settingRepository
    )
  }()

  static let syncUseCase: SyncUseCase = {
    return SyncUseCase(
      calendarRepository: calendarRepository,
      settingRepository: settingRepository
    )
  }()

  static var settingRepository: SettingRepositoryType = {
    return SettingRepository()
  }()

  static var calendarRepository: CalendarRepositoryType = {
    return CalendarRepository(
      local: CalendarLocalDataSource(
        database: CalendarDatabase()
      ),
      remote: CalendarRemoteDataSource(
        calServices: [appleCalendarService]
      )
    )
  }()

  static var appleCalendarService: CalendarServiceType = {
    return AppleCalendarService()
  }()

}

class Navigator {
  var window: UIWindow
  weak var view: UIViewController?

  init(window: UIWindow) {
    self.window = window
  }

  func show(_ viewType: ViewType, transition: TransitionType, animated: Bool = true) {
    var view = viewType.instantiateViewController()
    let navigator = Navigator(window: window)
    navigator.view = view
    view.navigator = navigator

    DispatchQueue.main.async {
      switch transition {
      case .root:
        self.window.rootViewController = view
      case .push:
        guard let navigationController = self.view?.navigationController else {
          fatalError("Can't push without a navigation controller")
        }
        navigationController.pushViewController(view, animated: animated)
      case .present:
        self.view?.present(view, animated: animated)
      }
    }
  }

  func pop(isModal: Bool = false, animated: Bool = true) {
    DispatchQueue.main.async {
      if let navigationController = self.view?.navigationController {
        if isModal {
          navigationController.dismiss(animated: animated, completion: nil)
        } else if navigationController.popViewController(animated: animated) == nil {
          if let presentingView = self.view?.presentingViewController {
            return presentingView.dismiss(animated: animated)
          } else {
            fatalError("Can't navigate back")
          }
        }
      } else if let presentingView = self.view?.presentingViewController {
        presentingView.dismiss(animated: animated)
      } else {
        fatalError("Neither modal nor navigation! Can't navigate back from \(String(describing: self.view))")
      }
    }
  }
}
