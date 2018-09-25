//
//  SelectionClearable.swift
//  UIHelpers
//
//  Created by Radoslav Blasko on 25/09/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

/// Describes an object that supports items selection/deselection
protocol ItemsSelectable {

    /// Returns index paths for selected rows or `nil` if none is selected.
    var indexPathsForSelectedItems: [IndexPath]? { get }

    /// Selects item at `indexPath`
    ///
    /// - Parameters:
    ///   - select: Either select or deselect.
    ///   - indexPath: An `IndexPath` of the desired item.
    ///   - animated: Whether or not to perfom animated.
    func selectItem(_ select: Bool, at indexPath: IndexPath, animated: Bool)
    func selectItems(_ select: Bool, at indexPaths: [IndexPath], animated: Bool)

}

extension ItemsSelectable {
    func selectItems(_ select: Bool, at indexPaths: [IndexPath], animated: Bool) {
        indexPaths.forEach { selectItem(select, at: $0, animated: animated) }
    }
}

extension UITableView: ItemsSelectable {
    var indexPathsForSelectedItems: [IndexPath]? {
        return indexPathsForSelectedRows
    }

    func selectItem(_ select: Bool, at indexPath: IndexPath, animated: Bool) {
        if select {
            deselectRow(at: indexPath, animated: animated)
        } else {
            selectRow(at: indexPath, animated: animated, scrollPosition: .none)
        }
    }
}

extension UICollectionView: ItemsSelectable {
    func selectItem(_ select: Bool, at indexPath: IndexPath, animated: Bool) {
        if select {
            deselectItem(at: indexPath, animated: animated)
        } else {
            selectItem(at: indexPath, animated: animated, scrollPosition: .init())
        }
    }
}

extension UIViewController {

    /// Clears selected items
    ///
    /// Provides nice animation regarding to ongoing transition and interaction.
    ///
    /// EXAMPLE:
    /// ```
    /// // typicall usage is inside UIViewController to handle tableView and collectionView
    /// // items deselection in viewWillAppear
    /// override func viewWillAppear(_ animated: Bool) {
    ///     super.viewWillAppear(animated)
    ///     clearSelectionInteractive(tableView, animated: animated)
    /// }
    ///
    /// override func viewWillAppear(_ animated: Bool) {
    ///     super.viewWillAppear(animated)
    ///     clearSelectionInteractive(collectionView, animated: animated)
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - view: A view that supports items selection/deselection.
    ///   - animated: Whether or not to perfom animated.
    func clearSelectionInteractive(_ view: ItemsSelectable?, animated: Bool) {
        guard let view = view, let indexPaths = view.indexPathsForSelectedItems else { return }

        if let coordinator = transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { (context) in
                if context.isAnimated, !context.isCancelled {
                    view.selectItems(true, at: indexPaths, animated: animated)
                }
            }
            coordinator.animate(alongsideTransition: { context in
                if !context.isInteractive, context.isAnimated {
                    view.selectItems(true, at: indexPaths, animated: animated)
                }
            }, completion: { context in
                if context.isCancelled {
                    view.selectItems(false, at: indexPaths, animated: false)
                }
            })
        } else {
            view.selectItems(true, at: indexPaths, animated: animated)
        }
    }

}
