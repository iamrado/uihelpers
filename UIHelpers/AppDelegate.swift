//
//  AppDelegate.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 19/03/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let window = UIWindow(frame: UIScreen.main.bounds)
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window.rootViewController = ViewController(nibName: nil, bundle: nil)
        window.makeKeyAndVisible()
    }
}
