//
//  DateFormatController.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

enum DateFormat {
  case api, monthDayYear

  fileprivate var formatString: String {
    switch self {
    case .api:
      return "yyyy-MM-dd"
    case .monthDayYear:
      return "MMM d, yyyy"
    }
  }

  fileprivate var formatter: DateFormatter {
    if let f = DateFormatController.sharedInstance.formats[self] {
      return f
    }

    let f = DateFormatter()
    f.dateFormat = self.formatString
    DateFormatController.sharedInstance.formats[self] = f

    return f
  }

  func string(from date: Date) -> String? {
    return formatter.string(from: date)
  }

  func date(from string: String) -> Date? {
    return formatter.date(from: string)
  }
}

class DateFormatController: NSObject {

  fileprivate static let sharedInstance = DateFormatController()
  fileprivate var formats = [DateFormat: DateFormatter]()

}
