//
//  StateView.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 12/08/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

final class StateView: UIView, ViewStatePresentable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        title = nil
        subtitle = nil
        image = nil
        buttonTitle = nil
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        onButtonTapped?()
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    var buttonTitle: String? {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }

    var onButtonTapped: (() -> Void)?

    static func instantiate() -> (ViewStatePresentable & UIView) {
        return UINib(nibName: "StateView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! StateView
    }
}
