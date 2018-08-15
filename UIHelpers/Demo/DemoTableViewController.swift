//
//  DemoTableViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 13/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController {
    private let cellReuseIdentifer = "CellIdentifier"
    private var items = [Item]()

    struct Item {
        let title: String
        let action: (() -> Void)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        items = DemoItemsFactory.create(for: self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifer)
        navigationController?.isToolbarHidden = false
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifer, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        item.action()
    }
}
