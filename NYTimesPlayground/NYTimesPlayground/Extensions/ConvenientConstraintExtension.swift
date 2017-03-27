//
//  ConvenientConstraintExtension.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//
//  Standard set of constraint extensions to make view-based layout creation
//  very consistent and easier to follow (plus more succint!)
//

import UIKit

extension NSLayoutConstraint {

  // MARK: Initialization Convenience

  convenience init(view1: UIView, view2: UIView, attribute: NSLayoutAttribute) {
    self.init(
      item: view1,
      attribute: attribute,
      relatedBy: .equal,
      toItem: view2,
      attribute: attribute,
      multiplier: 1.0,
      constant: 0.0
    )
  }

}

extension UIView {

  // MARK: Aspect Ratio

  func constrainAspectRatio(view: UIView, ratio: CGFloat) {
    addConstraint(
      NSLayoutConstraint(
        item: view,
        attribute: .height,
        relatedBy: .equal,
        toItem: view,
        attribute: .width,
        multiplier: ratio,
        constant: ratio
      )
    )
  }

  // MARK: Visual Constraints

  func visualConstraints(_ formatStrings: [String], metrics: [String: AnyObject]?, views: [String: AnyObject]) {
    for f in formatStrings {
      addConstraints(
        NSLayoutConstraint.constraints(
          withVisualFormat: f,
          options: NSLayoutFormatOptions(rawValue: 0),
          metrics: metrics,
          views: views
        )
      )
    }
  }

  // MARK: Center Alignment

  func centerSubviews(_ views: [UIView]) {
    centerSubviewsVertically(views)
    centerSubviewsHorizontally(views)
  }

  func centerSubviewsHorizontally(_ views: [UIView]) {
    views.forEach({addConstraint(NSLayoutConstraint(view1: $0, view2: self, attribute: .centerX))})
  }

  func centerSubviewsVertically(_ views: [UIView]) {
    views.forEach({addConstraint(NSLayoutConstraint(view1: $0, view2: self, attribute: .centerY))})
  }

  // MARK: Matching Attributes

  func matchAttributes(views: [UIView], attributes: [NSLayoutAttribute]) {
    let v = views.first
    for subview in views {
      if v != nil && v! != subview {
        attributes.forEach({addConstraint(NSLayoutConstraint(view1: v!, view2: subview, attribute: $0))})
      }
    }
  }

}
