//
//  UIImageScaleHelperTests.swift
//  UIHelpersTests
//
//  Created by Radoslav Blasko on 11/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
import AVFoundation
@testable import UIHelpers

class UIImageScaleHelperTests: XCTestCase {
    // MARK: - Helper methods
    func drawRect(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let rect = CGRect(origin: .zero, size: size)
        let path = UIBezierPath(rect: rect)

        UIColor.black.setFill()
        path.fill()

        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return img
    }

    // MARK: - Aspect fit tests
    func testScalingModeFitPortraitToLandscapeEnlarge() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 60, height: 40)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 2.0)
    }

    func testScalingModeFitLandscapeToPortraitEnlarge() {
        let originalSize = CGSize(width: 60, height: 20)
        let newSize = CGSize(width: 120, height: 40)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 2.0)
    }

    func testScalingModeFitPortraitToLandscapeShrink() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 20, height: 10)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 0.5)
    }

    func testScalingModeFitLandscapeToPortraitShrink() {
        let originalSize = CGSize(width: 20, height: 10)
        let newSize = CGSize(width: 2, height: 5)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 0.1)
    }

    func testScalingModeFitLandscapeToLandscapeShrink() {
        let originalSize = CGSize(width: 20, height: 10)
        let newSize = CGSize(width: 10, height: 5)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 0.5)
    }

    func testScalingModeFitPortraitToPortraitShrink() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 4, height: 10)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 0.4)
    }

    func testScalingModeFitLandscapeToLandscapeEnlarge() {
        let originalSize = CGSize(width: 20, height: 10)
        let newSize = CGSize(width: 30, height: 20)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 1.5)
    }

    func testScalingModeFitPortraitToPortraitEnlarge() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 30, height: 40)
        let result = UIImage.ScalingMode.aspectFit.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 2.0)
    }

    // MARK: - Aspect fill tests
    func testScalingModeFillPortraitToLandscapeEnlarge() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 30, height: 10)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 3.0)
    }

    func testScalingModeFillLandscapeToPortraitEnlarge() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 60, height: 40)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 6.0)
    }

    func testScalingModeFillPortraitToLandscapeShrink() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 21, height: 10)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 2.1)
    }

    func testScalingModeFillLandscapeToPortraitShrink() {
        let originalSize = CGSize(width: 20, height: 10)
        let newSize = CGSize(width: 2, height: 5)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 0.5)
    }

    func testScalingModeFillLandscapeToLandscapeShrink() {
        let originalSize = CGSize(width: 20, height: 10)
        let newSize = CGSize(width: 11, height: 5)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 0.55)
    }

    func testScalingModeFillPortraitToPortraitShrink() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 4, height: 10)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 0.5)
    }

    func testScalingModeFillLandscapeToLandscapeEnlarge() {
        let originalSize = CGSize(width: 20, height: 10)
        let newSize = CGSize(width: 33, height: 20)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 2.0)
    }

    func testScalingModeFillPortraitToPortraitEnlarge() {
        let originalSize = CGSize(width: 10, height: 20)
        let newSize = CGSize(width: 33, height: 40)
        let result = UIImage.ScalingMode.aspectFill.aspectRatio(original: originalSize, new: newSize)
        XCTAssertEqual(result, 3.3)
    }

    // MARK: - Resize tests
    func testScaledImageAspectFit() {
        let originalSize = CGSize(width: 10, height: 20)
        let scaledSize = CGSize(width: 33, height: 15)
        let original = drawRect(size: originalSize)
        let resized = original.scaled(to: scaledSize, mode: .aspectFit)
        XCTAssertEqual(resized.size, scaledSize)
    }

    func testScaledImageAspectFill() {
        let originalSize = CGSize(width: 20, height: 10)
        let scaledSize = CGSize(width: 333, height: 21)
        let original = drawRect(size: originalSize)
        let resized = original.scaled(to: scaledSize, mode: .aspectFill)
        XCTAssertEqual(resized.size, scaledSize)
    }
}
