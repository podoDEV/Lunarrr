//
//  EventListViewController.swift
//  Lunarrr
//
//  Created by hb1love on 2019/10/12.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class EventListViewController: UIViewController {
  @IBOutlet weak var eventTableView: UITableView!
  @IBOutlet weak var settingButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    eventTableView.register(UINib(nibName: "EventCell", bundle: Bundle.main), forCellReuseIdentifier: "EventCell")
  }

  @IBAction func didTapSetting(_ sender: Any) {
    let vc = SettingViewController.controllerFromStoryboard("Setting")
    present(vc, animated: true)
  }

  @IBAction func didTapWrite(_ sender: Any) {
    let vc = EventEditViewController.controllerFromStoryboard("EventEdit")
    present(vc, animated: true)
  }
}

extension EventListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
    cell.event = Event(title: "어머니 생신", date: Date())
    return cell
  }
}

extension EventListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = EventEditViewController.controllerFromStoryboard("EventEdit")
    vc.mode = .edit(Event(title: "어머니 생신", date: Date()))
    present(vc, animated: true)
  }
}
