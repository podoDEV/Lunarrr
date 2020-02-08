//
//  EventListViewController.swift
//  Lunarrr
//
//  Created by hb1love on 2019/10/12.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit
import AVFoundation

final class EventListViewController: BaseViewController {
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var eventTableView: UITableView!
  @IBOutlet weak var settingButton: UIButton!
  @IBOutlet weak var writeButton: UIButton!

  var eventUseCase: EventUseCase?
  var events: [Event] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    analytics.log(.eventlist_view)
    eventTableView.register(UINib(nibName: "EventCell", bundle: Bundle.main), forCellReuseIdentifier: "EventCell")
    let borderColor = UIColor(named: "border")
    settingButton.layer.borderColor = borderColor?.cgColor
    writeButton.layer.borderColor = borderColor?.cgColor
    reload()
  }

  @IBAction func settingWasTapped(_ sender: Any) {
    navigator?.show(.setting, transition: .present)
  }

  @IBAction func writingTouchDown(_ sender: Any) {
    Vibration.heavy.vibrate()
    UIView.animate(withDuration: 0.2) {
      self.writeButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }
  }

  @IBAction func writingTouchUpInside(_ sender: Any) {
    Vibration.heavy.vibrate()
    UIView.animate(
      withDuration: 0.2,
      animations: {
        self.writeButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    },
      completion: { _ in
        UIView.animate(withDuration: 0.1) {
          self.writeButton.transform = CGAffineTransform.identity
          self.navigator?.show(.eventEdit(mode: .new, completion: self.reload), transition: .present)
        }
    })
  }

  @IBAction func writingTouchUpOutside(_ sender: Any) {
    UIView.animate(withDuration: 0.2) {
      self.writeButton.transform = CGAffineTransform.identity
    }
  }

  func reload() {
    yearLabel.text = "\(Date.currentYear)년"
    events = eventUseCase?.getAll() ?? []
    eventTableView.reloadData()
  }
}

extension EventListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
    cell.event = events[indexPath.row]
    return cell
  }
}

extension EventListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    Vibration.medium.vibrate()
    navigator?.show(
      .eventEdit(
        mode: .edit(events[indexPath.row]),
        completion: reload
      ),
      transition: .present
    )
  }
}
