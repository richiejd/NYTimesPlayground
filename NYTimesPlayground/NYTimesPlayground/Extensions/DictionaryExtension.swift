//
//  DictionaryExtension.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

extension NSDictionary {

  // this supports key1.key2.key3, allowing you to access
  // nested elements of dictionary without having to
  // uniquely handle the object that the subsequent keys
  // are nested in
  func convert<T>(key: String, fallback: T) -> T {
    let components = key.components(separatedBy: ".")
    if components.count == 0 {
      return fallback
    }
    var priorDict: NSDictionary = self
    var index = 0
    while index < components.count - 1 {
      if let dict = priorDict[components[index]] as? NSDictionary {
        priorDict = dict
        index = index + 1
      } else {
        return fallback
      }
    }

    if let item = priorDict[components.last!] as? T {
      return item
    } else {
      return fallback
    }
  }
}
