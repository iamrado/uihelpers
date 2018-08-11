//
//  UIImageDrawHelper.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 19/03/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UIImage {
    /// Draws rectangle image.
    ///
    /// - Parameters:
    ///   - size: A size of rectangle image.
    ///   - cornerRadius: If greater than zero the output is oval rectangle. `Default 0.0`.
    ///   - strokeWidth: Specifies the border width. No border if 0.0 is passed. `Default 0.0`.
    ///   - strokeColor: A color of a border. `Default nil`.
    ///   - fillColor: A color of rectangle fillings. `Default nil`.
    ///   - opaque: Set to `true` if you are sure that there is no need for alpha channel. `Default true`.
    /// - Returns: A rectangle image.
    static func drawRect(with size: CGSize,
                         cornerRadius: CGFloat = 0.0,
                         strokeWidth: CGFloat = 0.0,
                         strokeColor: UIColor? = nil,
                         fillColor: UIColor? = nil,
                         opaque: Bool = true) -> UIImage {
        assert(size != .zero, "Invalid parameter: drawing an image with zero size, really?")
        assert(size.width - 2 * strokeWidth >= 0 && size.height - 2 * strokeWidth >= 0,
               "Invalid parameter: could not draw specified stroke width (\(strokeWidth) within size: \(size)!")
        assert(fillColor != nil || strokeColor != nil,
               "Invalid parameter: you have to set fillColor or strokeColor!")
        assert(strokeWidth == 0.0 || (strokeWidth >= 0.0 && strokeColor != nil),
               "Invalid parameter: you have to set both strokeWidth and strokeColor!")

        UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0)
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: 2 * strokeWidth, dy: 2 * strokeWidth)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

        if let fillColor = fillColor {
            fillColor.setFill()
            path.fill()
        }

        if let strokeColor = strokeColor {
            strokeColor.setStroke()
            path.lineWidth = strokeWidth
            path.stroke()
        }

        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return img
    }
}
