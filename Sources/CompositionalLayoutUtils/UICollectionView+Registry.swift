//
//  UICollectionView+Registry.swift
//  
//
//  Created by Ugur Bozkurt on 26/11/2022.
//

import UIKit

fileprivate var associateKey: Void?

public extension UICollectionView {

    private var registry: Registry {
        get {
            let obj = objc_getAssociatedObject(self, &associateKey) as? Registry
            if let obj = obj {
                return obj
            } else {
                let value = Registry()
                objc_setAssociatedObject(self, &associateKey, value, .OBJC_ASSOCIATION_RETAIN)
                return value
            }
        }
        set {
            objc_setAssociatedObject(self, &associateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    func register<Cell: Dequeueing & Registering, Item: ItemProviding>(cell: Cell.Type, item: Item.Type) {
        registry.register(cell: cell, item: item)
    }

    func dequeueCell(indexPath: IndexPath, item: AnyItem) -> UICollectionViewCell {
        registry.dequeueCell(self, indexPath: indexPath, item: item)
    }
}
