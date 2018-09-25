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

    struct UserInfo {
        let title: String
        let subtitle: String?
        let img: UIImage?
        let action: Action?
    }

    struct Action {
        let title: String
        let block: () -> Void
    }

    let rootView: UIView?

    private(set) var presentedView: StatePresentableView?
    private(set) var state: State?
    private(set) var viewStateClasses = [State: ViewStatePresentable.Type]()
    private var layoutStateView: ((StatePresentableView) -> Void)!

    /// Initializer
    ///
    /// - Parameter rootView: Default
    init(rootView: UIView?) {
        self.rootView = rootView

        State.allCases.forEach { (state) in
            switch state {
            case .activity:
                self.register(viewClass: ActivityStateView.self, for: state)
            case .empty, .error:
                self.register(viewClass: StateView.self, for: state)
            }
        }

        setLayoutStateViewHandler(nil)
    }

    /// Presents the particular state with desired info
    ///
    /// - Parameters:
    ///   - state: A state to present.
    ///   - userInfo: Holds the data for StatePresentable view. Use to customize the texts, image and button of ViewStatePresentable view.
    func present(state: ViewStatePresenter.State?, userInfo: ViewStatePresenter.UserInfo?) {
        presentedView?.removeFromSuperview()
        guard let state = state else { return }
        guard let viewClass = viewStateClasses[state] else { preconditionFailure("Unexpectedly found nil view class for \(state)") }

        var view = viewClass.instantiate()
        view.title = userInfo?.title
        view.subtitle = userInfo?.subtitle
        view.image = userInfo?.img
        view.buttonTitle = userInfo?.action?.title
        view.onButtonTapped = userInfo?.action?.block

        self.state = state
        presentedView = view
        layoutStateView(view)
    }

    /// Registers the state view class for particular state
    ///
    /// - Parameters:
    ///   - viewClass: A view that will be registered for a given state.
    ///   - state: A state.
    func register(viewClass: ViewStatePresentable.Type, for state: ViewStatePresenter.State) {
        viewStateClasses[state] = viewClass
    }

    /// Sets the custom state view layout handler
    ///
    /// It's your responsibility to add state view as a subview and provide cpnstraints or frame.
    ///
    /// - Parameter handler: Custom state view layout handler
    func setLayoutStateViewHandler(_ handler: ((StatePresentableView) -> Void)?) {
        if let handler = handler {
            layoutStateView = handler
        } else {
            layoutStateView = { [weak self] (stateView) in
                self?.layout(stateView: stateView)
            }
        }
    }

    private func layout(stateView: StatePresentableView) {
        guard let rootView = rootView else {
            preconditionFailure("Missing rootView! You have to either set the rootView or specify your custom layout handler.")
        }

        stateView.translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(stateView)

        let views = ["view": stateView]
        let ver = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .init(rawValue: 0), metrics: nil, views: views)
        let hor = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .init(rawValue: 0), metrics: nil, views: views)
        NSLayoutConstraint.activate(ver)
        NSLayoutConstraint.activate(hor)
    }
}
