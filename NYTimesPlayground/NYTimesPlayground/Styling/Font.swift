//
//  Font.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

enum Font {
  case regular, bold

  var name: String {
    switch self {
    case .regular:
      return "AvenirNext-Regular"
    case .bold:
      return "AvenirNext-Bold"
    }
  }

  func ui(size: CGFloat) -> UIFont {
    return UIFont(name: self.name, size: size)!
  }
}
