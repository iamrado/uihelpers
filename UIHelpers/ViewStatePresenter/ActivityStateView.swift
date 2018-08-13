//
//  ActivityStateView.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 12/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

final class ActivityStateView: UIView, ViewStatePresentable {
    @IBOutlet dynamic weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet dynamic weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var activityStackView: UIStackView!

    var title: String? {
        didSet {
            titleLabel.text = title

            if title?.count ?? 0 == 0 {
                titleLabel.removeFromSuperview()
            } else {
                activityStackView.addArrangedSubview(titleLabel)
            }
        }
    }
    var buttonTitle: String? {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }

    var subtitle: String?
    var image: UIImage?
    var onButtonTapped: (() -> Void)?

    static func instantiate() -> (ViewStatePresentable & UIView) {
        return UINib(nibName: "ActivityStateView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ActivityStateView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = NSLocalizedString("Loading...", comment: "Activity state view title")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        button.setTitle(nil, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        onButtonTapped?()
    }
}
