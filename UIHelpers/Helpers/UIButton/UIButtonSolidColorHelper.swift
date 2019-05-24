//
//  UIButtonSolidColorHelper.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 12/10/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let img = UIButton.crateImage(of: color)
        setBackgroundImage(img, for: state)
    }

    private static func crateImage(of color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        color.setFill()

        let path = UIBezierPath(rect: rect)
        path.fill()

        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return img
    }
}
