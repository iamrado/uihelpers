//
//  ViewStatePresenterViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 12/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class ViewStatePresenterViewController: UIViewController {
    private var statePresenter: ViewStatePresenter!
    private let states = State.allCases

    private enum State: String, CaseIterable {
        case empty
        case fetching
        case error
        case activity
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        statePresenter = ViewStatePresenter(rootView: view)

        let initalState = State.empty
        setupMenu(initalState)
        set(state: initalState)
    }

    private func presentEmpty() {
        let action = ViewStatePresenter.Action(title: "Retry") { [weak self] in
            self?.presentFetching()
        }
        let info = ViewStatePresenter.UserInfo(title: "Nothing to see :]",
                                               subtitle: "Nothing here right now. Come back later!",
                                               img: nil,
                                               action: action)
        statePresenter.present(state: .empty, userInfo: info)
    }

    private func presentFetching() {
        let action = ViewStatePresenter.Action(title: "Cancel", block: { [weak self] in
            self?.presentEmpty()
        })
        let info = ViewStatePresenter.UserInfo(title: "Fetching data... :|", subtitle: nil, img: nil, action: action)
        statePresenter.present(state: .activity, userInfo: info)
    }

    private func presentActivity() {
        let info = ViewStatePresenter.UserInfo(title: "", subtitle: nil, img: nil, action: nil)
        statePresenter.present(state: .activity, userInfo: info)
    }

    private func presentError() {
        let action = ViewStatePresenter.Action(title: "Retry") { [weak self] in
            self?.presentFetching()
        }
        let info = ViewStatePresenter.UserInfo(title: "Ooooh no =!", subtitle: "Check your Internet Connection.", img: nil, action: action)
        statePresenter.present(state: .error, userInfo: info)
    }

    private func set(state: State) {
        switch state {
        case .empty:
            presentEmpty()
        case .fetching:
            presentFetching()
        case .error:
            presentError()
        case .activity:
            presentActivity()
        }
    }

    private func setupMenu(_ initialState: State) {
        let segControl = UISegmentedControl(items: states.map { $0.rawValue.capitalized })
        segControl.addTarget(self, action: #selector(segmentChanged(sender:)), for: .valueChanged)
        segControl.selectedSegmentIndex = states.firstIndex(of: initialState) ?? 0
        setToolbarItems([UIBarButtonItem(customView: segControl)], animated: true)
    }

    @objc private func segmentChanged(sender: UISegmentedControl) {
        let state = states[sender.selectedSegmentIndex]
        set(state: state)
    }
}
