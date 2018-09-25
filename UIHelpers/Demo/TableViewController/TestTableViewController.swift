//
//  TestTableViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 24/09/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class TestTableViewController: TableViewController {
    fileprivate struct ReuseIdentifier {
        static let cell = "cellReuseIdentifier"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.cell)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TestTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.cell, for: indexPath)
    }
}

extension TestTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCntrl = TestTableViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(viewCntrl, animated: true)
    }
}
