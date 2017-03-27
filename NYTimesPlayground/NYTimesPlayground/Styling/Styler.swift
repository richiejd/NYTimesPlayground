//
//  Styler.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

extension UIButton {

  convenience init(title: String, titleColor: Color, titleFont: Font, titleFontSize: CGFloat, translatesARMIC: Bool) {
    self.init(frame: .zero)
    self.setTitle(title, for: UIControlState())
    self.setTitleColor(titleColor.ui, for: UIControlState())
    self.titleLabel?.font = titleFont.ui(size: titleFontSize)
    self.translatesAutoresizingMaskIntoConstraints = translatesARMIC
  }

}

extension UILabel {

  convenience init(title: String, color: Color, font: Font, fontSize: CGFloat, translatesARMIC: Bool) {
    self.init(frame: .zero)
    self.text = title
    self.textColor = color.ui
    self.font = font.ui(size: fontSize)
    self.translatesAutoresizingMaskIntoConstraints = translatesARMIC
  }

}

extension UIView {

  convenience init(backgroundColor: Color, translatesARMIC: Bool) {
    self.init(frame: .zero)
    self.backgroundColor = backgroundColor.ui
    self.translatesAutoresizingMaskIntoConstraints = translatesARMIC
  }

}
