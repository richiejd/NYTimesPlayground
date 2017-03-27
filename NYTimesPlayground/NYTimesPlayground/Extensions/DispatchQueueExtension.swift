//
//  DispatchQueueExtension.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

extension DispatchQueue {

  func asyncFromNow(delayInSeconds: Double, execute: @escaping () -> Void) {
    let time = DispatchTime.now() + Double((Int64(CGFloat(delayInSeconds)*CGFloat(NSEC_PER_SEC)))) / Double(NSEC_PER_SEC)
    asyncAfter(deadline: time, execute: execute)
  }

}
