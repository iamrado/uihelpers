//
//  ViewStatePresenterTests.swift
//  UIHelpersTests
//
//  Created by Radoslav Blasko on 12/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import UIHelpers

class ViewStatePresenterTests: XCTestCase {
    private var window: UIWindow {
        return UIApplication.shared.keyWindow!
    }

    private var rootViewController: UIViewController {
        return window.rootViewController!
    }

    override func setUp() {
        if UIApplication.shared.keyWindow == nil {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.makeKeyAndVisible()
            window.rootViewController = UIViewController(nibName: nil, bundle: nil)
        }
    }

    func testViewPresenterDefaultLayout() {
        let statePresenter = ViewStatePresenter(rootView: rootViewController.view)
        statePresenter.present(state: .empty, info: nil)
        let exp = expectation(description: "wait for layout")
        XCTWaiter().wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(statePresenter.presentedView!.frame, CGRect(origin: .zero, size: statePresenter.rootView.frame.size))
    }
}
