//
//  ViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 12/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var statePresenter: ViewStatePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        statePresenter = ViewStatePresenter(rootView: self.view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentEmpty()
    }

    private func presentEmpty() {
        let action = ViewStatePresenter.Action(title: "Retry") {
            let action = ViewStatePresenter.Action(title: "Cancel", block: {
                self.presentEmpty()
            })
            let info = ViewStatePresenter.Info(title: "Fetching data...", subtitle: "This may take a litle while", img: nil, action: action)
            self.statePresenter.present(state: .activity, info: info)
        }
        let info = ViewStatePresenter.Info(title: "Nothing to see :]", subtitle: "Nothing here right now. Come back later!", img: nil, action: action)
        statePresenter.present(state: .empty, info: info)
    }
}
