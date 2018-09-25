//
//  TestCollectionViewController.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 24/09/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class TestCollectionViewController: CollectionViewController {
    fileprivate struct ReuseIdentifier {
        static let cell = "cellReuseIdentifier"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 60)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.register(Cell.self, forCellWithReuseIdentifier: ReuseIdentifier.cell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.8977298141, green: 0.8912405372, blue: 0.9026982188, alpha: 1)
    }
}

extension TestCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.cell, for: indexPath)
        return cell
    }
}

extension TestCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewCntrl = TestCollectionViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(viewCntrl, animated: true)
    }
}

private class Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        let bgView = UIView(frame: CGRect(origin: .zero, size: frame.size))
        bgView.backgroundColor = #colorLiteral(red: 0.8509057164, green: 0.8510286212, blue: 0.8508786559, alpha: 1)
        selectedBackgroundView = bgView
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
