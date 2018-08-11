//
//  UIViewControllerStoryboardHelper.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 11/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Instantiates UIViewController from UIStoryboard.
    ///
    /// - Parameters:
    ///   - name: A name of the storyboard. View controller's class name by `default`.
    ///   - identifier: A view controller identifier within storyboard. `Default` nil.
    ///   - bundle: A bundle where to look for a storyboard.
    /// - Returns: UIViewController instance
    ///
    /// EXAMPLE:
    /// ```
    /// let viewController: MyViewControllerClass = MyViewControllerClass.instantiate()
    /// ```
    ///
    static func instantiate<T>(name: String = String(describing: T.self),
                               identifier: String? = nil,
                               bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        if let identifier = identifier {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! T
        } else {
            return storyboard.instantiateInitialViewController() as! T
        }
    }
}
