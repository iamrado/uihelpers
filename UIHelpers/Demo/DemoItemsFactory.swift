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
        func item(title: String, viewController viewControllerClass: UIViewController.Type) -> Item {
            return Item(title: title) { [weak viewController] in
                let viewCntrl = viewControllerClass.init(nibName: nil, bundle: nil)
                viewCntrl.title = title
                viewController?.navigationController?.pushViewController(viewCntrl, animated: true)
            }
        }

        let items = [item(title: "View State Presenter", viewController: ViewStatePresenterViewController.self),
                     item(title: "Keyboard Handler", viewController: KeyboardInsetsHandlerViewController.self),
                     item(title: "TableViewContorller", viewController: TestTableViewController.self),
                     item(title: "CollectionViewContorller", viewController: TestCollectionViewController.self)]
        return items
    }

}
