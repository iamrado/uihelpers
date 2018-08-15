//
//  KeyboardInsetsHandler.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 15/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

final class KeyboardInsetsHandler {
    var isAdjustingInsetsBySafeArea = true
    var isEnabled = false {
        didSet(prevValue) {
            guard prevValue != isEnabled else { return }

            let center = NotificationCenter.default

            if isEnabled {
                center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            } else {
                center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
                center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            }
        }
    }

    private(set) weak var scrollView: UIScrollView!
    private(set) weak var rootView: UIView?

    private enum Transition {
        case show
        case hide
    }

    init(rootView: UIView?, scrollView: UIScrollView) {
        self.rootView = rootView
        self.scrollView = scrollView
    }

    deinit {
        isEnabled = false
    }

    @objc private func keyboardWillShow(_ notif: Notification) {
        let info = KeyboardNotificationInfo(notif: notif)
        setInset(for: .show, info: info)
    }

    @objc private func keyboardWillHide(_ notif: Notification) {
        let info = KeyboardNotificationInfo(notif: notif)
        setInset(for: .hide, info: info)
    }

    private func setInset(for transition: Transition, info: KeyboardNotificationInfo) {
        var contentInset = scrollView.contentInset

        switch transition {
        case .show:
            contentInset.bottom = info.endFrame.height

            if isAdjustingInsetsBySafeArea, let rootView = rootView {
                contentInset.bottom -= rootView.safeAreaInsets.bottom
            }
        case .hide:
            contentInset.bottom = 0
        }

        var scrollIndicatorsInset = scrollView.scrollIndicatorInsets
        scrollIndicatorsInset.bottom = contentInset.bottom

        UIView.animate(withDuration: info.animation.duration, delay: 0, options: info.animation.options, animations: {
            self.scrollView.contentInset = contentInset
            self.scrollView.scrollIndicatorInsets = scrollIndicatorsInset
        }, completion: nil)
    }
}
