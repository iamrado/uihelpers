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
            let stateViewDemoViewController = ViewStatePresenterViewController(nibName: nil, bundle: nil)
            stateViewDemoViewController.title = stateViewDemoTitle
            weakViewController?.navigationController?.pushViewController(stateViewDemoViewController, animated: true)
        }

        return [stateViewDemo]
    }
}
