//
//  TableViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 24/09/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

/// Mimics some of the UITableViewController's behaviours while adding the `tableView` as a subview of `view`.
///
/// Currently supported features:
/// * flash scroll indicators
/// * deselect rows
class TableViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var clearsSelectionOnViewWillAppear = true
    var automaticallyFlashScrollIndicators = true

    override func loadView() {
        super.loadView()

        if tableView == nil {
            let frame = CGRect(origin: .zero, size: view.frame.size)
            tableView = UITableView(frame: frame, style: .plain)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)

            let constraints = [tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                               tableView.topAnchor.constraint(equalTo: view.topAnchor),
                               tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                               tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
            NSLayoutConstraint.activate(constraints)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if clearsSelectionOnViewWillAppear { clearSelectionInteractive(tableView, animated: animated) }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if automaticallyFlashScrollIndicators { tableView.flashScrollIndicators() }
    }
}
