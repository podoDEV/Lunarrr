//
//  SyncCell.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/17.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class SyncCell: UITableViewCell {
  @IBOutlet weak var calendarImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var syncSwitch: UISwitch!

  var provider: CalendarProvider? {
    didSet {
      titleLabel.text = provider?.title
      syncSwitch.isHidden = true
    }
  }
}
