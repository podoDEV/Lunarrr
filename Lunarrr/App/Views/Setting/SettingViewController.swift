//
//  SettingViewController.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/02.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class SettingViewController: BaseViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var closeButton: UIButton!

  var syncCalendars: [CalendarProvider] = [.apple, .google]

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "SyncCell", bundle: Bundle.main), forCellReuseIdentifier: "SyncCell")
    analytics.log(.setting_view)
    if #available(iOS 13, *) {
      closeButton.isHidden = true
    }
  }

  @IBAction func closeWasTapped(_ sender: Any) {
    navigator?.pop(isModal: true)
  }
}

extension SettingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return syncCalendars.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SyncCell") as! SyncCell
    cell.provider = syncCalendars[indexPath.row]
    return cell
  }
}
