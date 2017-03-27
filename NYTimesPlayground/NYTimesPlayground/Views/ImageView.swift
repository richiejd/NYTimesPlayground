//
//  ImageView.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import Nuke
import UIKit

class ImageView: UIImageView {

  var imageModel: Image? {
    willSet {
      if imageModel?.url != newValue?.url {
        Nuke.cancelRequest(for: self)
        image = nil
      }
      if let img = newValue?.storedImage {
        image = img
      } else if let url = newValue?.url {
        let model = newValue!
        if let urlObject = URL(string: url) {
          Nuke.loadImage(with: urlObject, into: self, handler: { [weak self](res, _) in
            self?.image = res.value
            model.storedImage = res.value
          })
        }
      }
    }
  }

}
