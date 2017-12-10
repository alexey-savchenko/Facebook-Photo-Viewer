//
//  AppDelegate.swift
//  Facebook Photo Viewer
//
//  Created by iosUser on 08.12.2017.
//  Copyright © 2017 svch. All rights reserved.
//

import UIKit
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: Coordinator!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = AppCoordinator(window: window!)
    appCoordinator.start()
    
    return true
  }

  func application(_ app: UIApplication,
                   open url: URL,
                   options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    
    let handled = FBSDKApplicationDelegate.sharedInstance().application(app,
                                                                        open: url,
                                                                        options: options)
    
    return handled
    
  }


}

