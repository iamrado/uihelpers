//
//  UIViewControllerHelperTests.swift
//  UIHelpersTests
//
//  Created by Radoslav Blasko on 11/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import UIHelpers

class UIViewControllerHelperTests: XCTestCase {
    private var window: UIWindow {
        return UIApplication.shared.keyWindow!
    }

    override func setUp() {
        if UIApplication.shared.keyWindow == nil {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.makeKeyAndVisible()
        }
    }

    func testTopViewControllerSelectedTabBarChild() {
        let tabBar = UITabBarController(nibName: nil, bundle: nil)
        let firstChild = UIViewController(nibName: nil, bundle: nil)
        let secondChild = UIViewController(nibName: nil, bundle: nil)
        tabBar.setViewControllers([firstChild, secondChild], animated: false)
        window.rootViewController = tabBar
        XCTAssertEqual(UIViewController.topViewController, firstChild)
        tabBar.selectedIndex = 1
        XCTAssertEqual(UIViewController.topViewController, secondChild)
    }

    func testTopViewControllerPushedChildInNavigationController() {
        let firstChild = UIViewController(nibName: nil, bundle: nil)
        let secondChild = UIViewController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: firstChild)
        window.rootViewController = navigationController
        XCTAssertEqual(UIViewController.topViewController, firstChild)

        navigationController.pushViewController(secondChild, animated: false)
        XCTAssertEqual(UIViewController.topViewController, secondChild)

        navigationController.popViewController(animated: false)
        XCTAssertEqual(UIViewController.topViewController, firstChild)
    }

    func testTopViewControllerModal() {
        let root = UIViewController(nibName: nil, bundle: nil)
        window.rootViewController = root
        XCTAssertEqual(UIViewController.topViewController, root)

        let modal = UIViewController(nibName: nil, bundle: nil)
        root.present(modal, animated: false, completion: nil)
        XCTAssertEqual(UIViewController.topViewController, modal)

        let exp = expectation(description: "wait")
        modal.dismiss(animated: false, completion: {
            XCTAssertEqual(UIViewController.topViewController, root)
            exp.fulfill()
        })

        wait(for: [exp], timeout: 1)
    }

    func testTopViewControllerModalOnModal() {
        let root = UIViewController(nibName: nil, bundle: nil)
        window.rootViewController = root

        var exp = expectation(description: "wait")
        let firstModal = UIViewController(nibName: nil, bundle: nil)
        root.present(firstModal, animated: false, completion: {
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(UIViewController.topViewController, firstModal)

        exp = expectation(description: "wait")
        let secondModal = UIViewController(nibName: nil, bundle: nil)
        firstModal.present(secondModal, animated: false, completion: {
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(UIViewController.topViewController, secondModal)

        exp = expectation(description: "wait")
        secondModal.dismiss(animated: false, completion: {
            exp.fulfill()
        })
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(UIViewController.topViewController, firstModal)
    }

    func testTopViewControllerReturnsNilWhenNotSet() {
        window.rootViewController = nil
        XCTAssertNil(UIViewController.topViewController)
    }
}
