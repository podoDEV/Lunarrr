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
  case eventList
  case eventEdit(mode: EventEditMode, completion: (() -> Void))
  case setting

  func instantiateViewController() -> UIViewController & Navigatable {
    switch self {
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
  private func makeEventListViewController() -> EventListViewController {
    let vc = EventListViewController.controllerFromStoryboard("EventList")
    vc.dataSource = type(of: self).calendarDataSource
    return vc
  }

  private func makeEventEditViewController(mode: EventEditMode, completion: @escaping (() -> Void)) -> EventEditViewController {
    let vc = EventEditViewController.controllerFromStoryboard("EventEdit")
    vc.dataSource = type(of: self).calendarDataSource
    vc.didEditFinish = completion
    vc.mode = mode
    return vc
  }

  private func makeSettingViewController() -> SettingViewController {
    let vc = SettingViewController.controllerFromStoryboard("Setting")
    return vc
  }

  static var calendarDataSource: CalendarDataSource = {
    return CalendarRepository(
      local: CalendarLocalRepository(
        database: CalendarDatabase()
      ),
      remote: CalendarRemoteRepository()
    )
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
