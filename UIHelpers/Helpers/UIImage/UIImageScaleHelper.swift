//
//  UIImageResizeHelper.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 19/03/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UIImage {
    /// Defines scaling mode for image
    ///
    /// - aspectFit: Fits the new size and no edge is cut.
    /// - aspectFill: Fills the whole size. Some edges might be cut.
    enum ScalingMode {
        case aspectFit
        case aspectFill

        /// Computes the aspect ration to use when scaling the image
        ///
        /// - Parameters:
        ///   - original: Current image size.
        ///   - new: Desired new image size.
        /// - Returns: Aspect ratio to use when scaling the image.
        func aspectRatio(original: CGSize, new: CGSize) -> CGFloat {
            let aspectWidth  = new.width / original.width
            let aspectHeight = new.height / original.height

            switch self {
            case .aspectFill:
                return max(aspectWidth, aspectHeight)
            case .aspectFit:
                return min(aspectWidth, aspectHeight)
            }
        }
    }

    /// Scales image using given scaling mode
    ///
    /// - Parameters:
    ///   - size: A new size for the image.
    ///   - mode: A scaling mode to use whe resizing. See ScalingMode.
    /// - Returns: Resized image.
    func scaled(to size: CGSize, mode: ScalingMode = .aspectFit) -> UIImage {
        let aspectRatio = mode.aspectRatio(original: self.size, new: size)
        var scaledImageRect = CGRect.zero
        scaledImageRect.size.width = size.width * aspectRatio
        scaledImageRect.size.height = size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - size.width * aspectRatio) / 2.0
        scaledImageRect.origin.y = (size.height - size.height * aspectRatio) / 2.0

        UIGraphicsBeginImageContext(size)
        draw(in: scaledImageRect)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return img
    }
}
