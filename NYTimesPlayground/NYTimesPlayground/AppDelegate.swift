//
//  AppDelegate.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: MoviesViewController())
    window?.makeKeyAndVisible()

    return true
  }
  
  
}

