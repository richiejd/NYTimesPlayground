//
//  Constants.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

struct Constants {

  struct Api {
    static let host = "https://api.nytimes.com"
  }

  struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxDimension = max(ScreenSize.width, ScreenSize.height)
    static let minDimension = min(ScreenSize.width, ScreenSize.height)

    static let iPhone6Width = CGFloat(375.0)
    static let iPhone6Height = CGFloat(667.0)
  }

}
