//
//  EventCell.swift
//  Lunarrr
//
//  Created by hb1love on 2019/10/26.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class EventCell : UITableViewCell {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var gregorianLabel: UILabel!
  @IBOutlet weak var lunarLabel: UILabel!

  var event: Event? {
    didSet {
      guard let event = self.event else { return }
      titleLabel.text = event.title
      lunarLabel.text = "음력".appending(event.date?.stringForLunar() ?? "")
      gregorianLabel.text = event.date?
        .toNearestFutureIncludingToday()?
        .stringForSolar()
    }
  }
}
