//
//  UIButton+Additions.swift
//  Lunarrr
//
//  Created by hb1love on 2019/11/16.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

extension UIButton {
  @IBInspectable var verticalEdgeInset: CGFloat {
    get {
      return self.contentEdgeInsets.top
    }
    set {
      self.contentEdgeInsets = UIEdgeInsets(
        top: newValue,
        left: contentEdgeInsets.left,
        bottom: newValue,
        right: contentEdgeInsets.right
      )
    }
  }

  @IBInspectable var horizontalEdgeInset: CGFloat {
    get {
      return self.contentEdgeInsets.left
    }
    set {
      self.contentEdgeInsets = UIEdgeInsets(
        top: contentEdgeInsets.top,
        left: newValue,
        bottom: contentEdgeInsets.bottom,
        right: newValue
      )
    }
  }
}
