//
//  EventListViewController.swift
//  Lunarrr
//
//  Created by hb1love on 2019/10/12.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class EventListViewController: BaseViewController {
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var eventTableView: UITableView!
  @IBOutlet weak var settingButton: UIButton!
  @IBOutlet weak var writeButton: UIButton!

  var dataSource: CalendarDataSource?
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

  @IBAction func writingWasTapped(_ sender: Any) {
    navigator?.show(.eventEdit(mode: .new, completion: reload), transition: .present)
  }

  func reload() {
    yearLabel.text = "\(Date.currentYear)년"
    events = dataSource?.events() ?? []
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
    navigator?.show(
      .eventEdit(
        mode: .edit(events[indexPath.row]),
        completion: reload
      ),
      transition: .present
    )
  }
}
