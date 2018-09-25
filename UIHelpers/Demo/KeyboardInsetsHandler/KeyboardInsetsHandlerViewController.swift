//
//  KeyboardInsetsHandlerViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 15/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class KeyboardInsetsHandlerViewController: UIViewController {
    private var tableView: UITableView!
    private let identifier = "CellReuseIdentifier"
    private var keybaordHandler: KeyboardInsetsHandler!

    override func loadView() {
        super.loadView()
        var frame = view.frame
        frame.origin = .zero
        tableView = UITableView(frame: frame, style: .plain)
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self

        let frame = CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 44))
        let textField = UITextField(frame: frame)
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.textAlignment = .center
        textField.placeholder = "Try me!"
        tableView.tableHeaderView = textField

        keybaordHandler = KeyboardInsetsHandler(rootView: view, scrollView: tableView)

        let resignItem = UIBarButtonItem(title: "Resign", style: .plain, target: self, action: #selector(resignButtonTapped))
        navigationItem.rightBarButtonItem = resignItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keybaordHandler.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keybaordHandler.isEnabled = false
    }

    @objc private func resignButtonTapped() {
        view.endEditing(true)
    }
}

extension KeyboardInsetsHandlerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.9709016681, green: 0.9638828635, blue: 0.9762752652, alpha: 1)
        return cell
    }
}
