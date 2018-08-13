//
//  UIViewNibHelper.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 13/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UIView {
    /// Loads the `UIView` from a .xib file
    ///
    /// - Parameters:
    ///   - name: A name of the `xib` file.
    ///   - bundle: Bundle name where the `xib` file is stored.
    ///   - owner: See `instantiate(withOwner:, options:)` in `UINib` interface.
    ///   - options: See `instantiate(withOwner:, options:)` in `UINib` interface.
    /// - Returns: UIView.
    ///
    /// EXAMPLE:
    /// ```
    /// let myView: MyView = MyView.loadFromNib()
    /// // or:
    /// let myView: MyView = .loadFromNib()
    /// ```
    static func loadFromNib<T>(name: String = String.init(describing: T.self), bundle: Bundle? = nil,
                               owner: AnyObject? = nil, options: [UINib.OptionsKey: Any]? = nil) -> T {
        let nib = UINib(nibName: name, bundle: bundle)
        guard let view = nib.instantiate(withOwner: owner, options: options).first as? T else {
            preconditionFailure("Could not instantiate view: \(self) from nib named: \(name) in bundle: \(String(describing: bundle))")
        }
        return view
    }
}
