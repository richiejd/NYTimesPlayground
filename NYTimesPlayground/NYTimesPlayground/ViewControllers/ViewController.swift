//
//  ViewController.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//
//  Base vc class if we want to apply functionality across the entire app
//

import UIKit

class ViewController: UIViewController {

  let apiClient = ApiClient()

  func dismissKeyboard() {
    UIApplication.shared.dismissKeyboard()
  }

}

