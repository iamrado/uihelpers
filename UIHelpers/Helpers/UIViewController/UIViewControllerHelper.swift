//
//  UIViewControllerHelper.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 19/03/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Returns top most visible view controller in key window's rootViewController.
    ///
    /// - Returns: top most visible view controller or nil if there is no rootViewController.
    ///
    static var topViewController: UIViewController? {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        return rootViewController.topViewController(with: rootViewController)
    }

    /// Returns visible view controller. Traverses the view controllers hierarchy and returns the top
    /// most visible view controller.
    ///
    /// - Parameter rootViewController: A view controller where to begin search for top view controller.
    /// - Returns: Top most visible view controller.
    func topViewController(with rootViewController: UIViewController) -> UIViewController {
        if let tabBarController = rootViewController as? UITabBarController, let selectedViewController = tabBarController.selectedViewController {
            return topViewController(with: selectedViewController)
        } else if let navigationController = rootViewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return topViewController(with: visibleViewController)
        } else if let presentedViewController = rootViewController.presentedViewController {
            return topViewController(with: presentedViewController)
        } else {
            return rootViewController
        }
    }
}
