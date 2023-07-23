//
//  Registry.swift
//  
//
//  Created by Ugur Bozkurt on 26/11/2022.
//

import UIKit

final class Registry {

    var dequeuables: [String: Dequeueing.Type] = [:]

    func register<Cell: Dequeueing & Registering, Item: ItemProviding>(cell: Cell.Type, item: Item.Type) {
        dequeuables[String(reflecting: item)] = cell
        _ = cell.registration
    }

    func dequeueCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: AnyItem) -> UICollectionViewCell {
        let cell = resolve(item.reusableIdentifier)
        return cell.dequeueCell(collectionView, indexPath: indexPath, item: item)
    }

    private func resolve(_ reuseId: String) -> Dequeueing.Type {
        guard let cell = dequeuables[reuseId] else { fatalError("Register cell for \(reuseId)") }
        return cell
    }
}
