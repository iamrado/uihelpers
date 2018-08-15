//
//  KeyboardNotificationInfo.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 15/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

struct KeyboardNotificationInfo {
    let beginFrame: CGRect
    let endFrame: CGRect
    let isLocal: Bool
    let animation: Animation

    struct Animation {
        let duration: TimeInterval
        let options: UIView.AnimationOptions
    }

    init(notif: Notification) {
        let userInfo = notif.userInfo!
        beginFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as! Bool

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let rawCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int
        let options = UIView.AnimationOptions(rawValue: UInt(rawCurve << 16))
        animation = Animation(duration: duration, options: options)
    }
}
