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

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "SyncCell", bundle: Bundle.main), forCellReuseIdentifier: "SyncCell")
  }
}

extension SettingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SyncCell") as! SyncCell
//    cell.event = Event(title: "어머니 생신", date: Date())
    return cell
  }
}
