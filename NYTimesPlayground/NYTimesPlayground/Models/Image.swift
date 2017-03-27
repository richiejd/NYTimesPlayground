//
//  Image.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

class Image: NSObject {

  var storedImage: UIImage?
  var url: String?

  init(url: String?) {
    self.url = url
    super.init()
  }

}
