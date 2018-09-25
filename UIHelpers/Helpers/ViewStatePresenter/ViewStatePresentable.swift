//
//  ViewStatePresentable.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 12/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

protocol ViewStatePresentable where Self: UIView {
    var title: String? { get set }
    var subtitle: String? { get set }
    var image: UIImage? { get set }
    var buttonTitle: String? { get set }
    var onButtonTapped: (() -> Void)? { get set }

    static func instantiate() -> (ViewStatePresentable & UIView)
}
