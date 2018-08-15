//
//  DemoItemsFactory.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 13/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class DemoItemsFactory {
    typealias Item = DemoTableViewController.Item
    static func create(for viewController: UIViewController) -> [Item] {
        weak var weakViewController = viewController

        let stateViewDemoTitle = "View State Presenter"
        let stateViewDemo = Item(title: stateViewDemoTitle) {
            let viewController = ViewStatePresenterViewController(nibName: nil, bundle: nil)
            viewController.title = stateViewDemoTitle
            weakViewController?.navigationController?.pushViewController(viewController, animated: true)
        }

        let keybaordHandlerTitle = "Keyboard Handler"
        let keyboardHandlerDemo = Item(title: keybaordHandlerTitle) {
            let viewController = KeyboardInsetsHandlerViewController(nibName: nil, bundle: nil)
            viewController.title = keybaordHandlerTitle
            weakViewController?.navigationController?.pushViewController(viewController, animated: true)
        }

        return [stateViewDemo, keyboardHandlerDemo]
    }
}
