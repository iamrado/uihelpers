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
        let demoViewController = DemoTableViewController(style: .plain)
        demoViewController.title = "Demo"
        window.rootViewController = UINavigationController(rootViewController: demoViewController)
        window.makeKeyAndVisible()
    }
}
