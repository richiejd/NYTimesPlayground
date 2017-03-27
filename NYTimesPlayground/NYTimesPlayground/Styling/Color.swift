//
//  Color.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

enum Color {
  case white, greyBackground, greyDivider, greyMedium, greyDark, black
  case clear

  var ui: UIColor {
    switch self {
    case .clear:
      return UIColor.clear
    default:
      return UIColor(hex: self.hex)
    }
  }

  var hex: Int {
    switch self {
    case .clear:
      return 0xFFFFFF
    case .greyBackground:
      return 0xF6F6F6
    case .greyMedium:
      return 0x9B9B9B
    case .greyDivider:
      return 0xD8D8D8
    case .greyDark:
      return 0x424242
    case .black:
      return 0x000000
    case .white:
      return 0xFFFFFF
    }
  }

  var cg: CGColor {
    return self.ui.cgColor
  }

  var highlighted: UIColor {
    if self == .white {
      return Color.greyBackground.ui
    } else if self == .greyBackground {
      return Color.greyDivider.ui
    } else {
      let hex = (Double(0xFFFFFF) * 0.2) + (Double(self.hex) * 0.8)
      return UIColor(hex: Int(hex))
    }
  }

  var contrasted: UIColor {
    if self == .white || self == .greyBackground || self == .greyDivider {
      return Color.greyDark.ui
    } else {
      return Color.white.ui
    }
  }
}
