//
//  UIColorExtension.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//
//  Extension on UIColor as I personally prefer and find designers tend to use hex values.
//

import UIKit

extension UIColor {

  convenience init(alpha: Double, red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
  }

  convenience init(hex:Int) {
    self.init(alpha: 1.0, red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
  }

  convenience init(hex:Int, alpha: Double) {
    self.init(alpha: alpha, red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
  }

  func rgbaValues() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
    var red = CGFloat(0.0), green = CGFloat(0.0), blue = CGFloat(0.0), alpha = CGFloat(0.0)
    getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    return (red, green, blue, alpha)
  }
  
}
