//
//  LaunchViewController.swift
//  Lunarrr
//
//  Created by hb1love on 2020/02/08.
//  Copyright © 2020 podo. All rights reserved.
//

import UIKit
import Lottie

final class LaunchViewController: BaseViewController {
  let animationView = AnimationView()

  override func viewDidLoad() {
    super.viewDidLoad()

    let animation = Animation.named("launch")
    animationView.animation = animation
    animationView.contentMode = .scaleAspectFit
    animationView.backgroundBehavior = .pauseAndRestore
    view.addSubview(animationView)

    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animationView.play(
      fromProgress: 0,
      toProgress: 1,
      loopMode: .playOnce
    ) { [weak self] (finished) in
      if finished {
        log.debug("Animation Complete")
        self?.navigator?.show(.eventList, transition: .root)
      } else {
        log.debug("Animation cancelled")
      }
    }
    Timer.scheduledTimer(
      withTimeInterval: 2,
      repeats: false
    ) { [weak self] _ in
      self?.navigator?.show(.eventList, transition: .root)
    }
  }
}
