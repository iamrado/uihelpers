//
//  ViewStatePresenter.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 12/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

final class ViewStatePresenter {
    typealias StatePresentableView = ViewStatePresentable & UIView

    enum State: CaseIterable {
        case empty
        case activity
        case error
    }

    struct Info {
        let title: String
        let subtitle: String?
        let img: UIImage?
        let action: Action?
    }

    struct Action {
        let title: String
        let block: () -> Void
    }

    var layoutStateView: ((StatePresentableView) -> Void)!
    let rootView: UIView

    private(set) var presentedView: StatePresentableView?
    private(set) var state: State?

    private var viewStateClasses = [State: ViewStatePresentable.Type]()

    init(rootView: UIView) {
        self.rootView = rootView

        layoutStateView = { (stateView) in
            self.layout(stateView: stateView)
        }

        State.allCases.forEach { (state) in
            switch state {
            case .activity:
                self.register(viewClass: ActivityStateView.self, for: state)
            case .empty, .error:
                self.register(viewClass: StateView.self, for: state)
            }
        }
    }

    func present(state: ViewStatePresenter.State?, info: ViewStatePresenter.Info?) {
        presentedView?.removeFromSuperview()
        guard let state = state, let viewClass = viewStateClasses[state] else { return }
        var view = viewClass.instantiate()
        view.title = info?.title
        view.subtitle = info?.subtitle
        view.image = info?.img
        view.buttonTitle = info?.action?.title
        view.onButtonTapped = info?.action?.block
        presentedView = view
        layoutStateView(view)
    }

    func register(viewClass: ViewStatePresentable.Type, for state: ViewStatePresenter.State) {
        viewStateClasses[state] = viewClass
    }

    private func layout(stateView: StatePresentableView) {
        stateView.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(stateView)

        let views = ["view": stateView]
        let ver = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .init(rawValue: 0), metrics: nil, views: views)
        let hor = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .init(rawValue: 0), metrics: nil, views: views)
        NSLayoutConstraint.activate(ver)
        NSLayoutConstraint.activate(hor)
    }
}
