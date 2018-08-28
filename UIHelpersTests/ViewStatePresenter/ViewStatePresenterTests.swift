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
        statePresenter.present(state: .empty, userInfo: nil)
        let exp = expectation(description: "wait for layout")
        XCTWaiter().wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(statePresenter.presentedView!.frame, CGRect(origin: .zero, size: statePresenter.rootView!.frame.size))
    }

    func testDefaultsAfterInit() {
        let presenter = ViewStatePresenter(rootView: rootViewController.view)
        for state in ViewStatePresenter.State.allCases {
            XCTAssertNotNil(presenter.viewStateClasses[state])
        }

        XCTAssertNil(presenter.presentedView)
        XCTAssertNil(presenter.state)
        XCTAssertEqual(presenter.rootView, rootViewController.view)
    }

    func testChangeStateCreatesNewView() {
        let presenter = ViewStatePresenter(rootView: rootViewController.view)
        presenter.present(state: .empty, userInfo: nil)
        XCTAssertNotNil(presenter.presentedView)
        let prevView = presenter.presentedView!
        presenter.present(state: .empty, userInfo: nil)
        XCTAssertTrue(prevView !== presenter.presentedView!)
    }

    func testPresentStateSetsState() {
        let presenter = ViewStatePresenter(rootView: rootViewController.view)
        let states = ViewStatePresenter.State.allCases
        for state in states {
            presenter.present(state: state, userInfo: nil)
            XCTAssertEqual(presenter.state, state)
        }
    }

    func testPresentNilRemovesFromSuperView() {
        let presenter = ViewStatePresenter(rootView: rootViewController.view)
        presenter.present(state: .error, userInfo: nil)
        let stateView = presenter.presentedView
        XCTAssertNotNil(stateView?.superview)
        presenter.present(state: nil, userInfo: nil)
        XCTAssertNil(stateView?.superview)
    }

    func testPresenterButtonAction() {
        let presenter = ViewStatePresenter(rootView: rootViewController.view)
        var buttonTapped = false
        let action: (() -> Void) = {
            buttonTapped = true
        }
        let info = ViewStatePresenter.UserInfo(title: "Title",
                                               subtitle: nil,
                                               img: nil,
                                               action: ViewStatePresenter.Action(title: "GO!", block: action))
        presenter.present(state: .empty, userInfo: info)
        presenter.presentedView!.onButtonTapped?()
        XCTAssertTrue(buttonTapped)
    }

    func testSettingNonNilInfoUpdatesStateView() {
        let presenter = ViewStatePresenter(rootView: rootViewController.view)
        let img = UIImage()
        let info = ViewStatePresenter.UserInfo(title: "Title",
                                               subtitle: "Subtitle",
                                               img: img,
                                               action: ViewStatePresenter.Action(title: "GO!", block: {}))
        presenter.present(state: .error, userInfo: info)

        let presented = presenter.presentedView!
        XCTAssertEqual(presented.title, "Title")
        XCTAssertEqual(presented.subtitle, "Subtitle")
        XCTAssertEqual(presented.image, img)
        XCTAssertEqual(presented.buttonTitle, "GO!")
    }
}
