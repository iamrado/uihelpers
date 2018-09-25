//
//  CollectionViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 24/09/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

/// Mimics some of the UICollectionViewController's behaviours while adding the `collectionView` as a subview of `view`.
///
/// Currently supported features:
/// * flash scroll indicators
/// * deselect rows
class CollectionViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    var clearsSelectionOnViewWillAppear = true
    var automaticallyFlashScrollIndicators = true

    override func loadView() {
        super.loadView()

        if collectionView == nil {
            let frame = CGRect(origin: .zero, size: view.frame.size)
            collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewLayout())
            collectionView.backgroundColor = .white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(collectionView)

            let constraints = [collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
                               collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                               collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
                               collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)]
            NSLayoutConstraint.activate(constraints)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if clearsSelectionOnViewWillAppear { clearSelectionInteractive(collectionView, animated: animated) }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if automaticallyFlashScrollIndicators { collectionView.flashScrollIndicators() }
    }
}
