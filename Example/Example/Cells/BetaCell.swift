//
//  BetaCell.swift
//  Example
//
//  Created by Ugur Bozkurt on 26/11/2022.
//

import UIKit
import CompositionalLayoutUtils

final class BetaCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

extension BetaCell: Registering {
    static var registration: UICollectionView.CellRegistration<BetaCell, AnyItem> =
    UICollectionView.CellRegistration<BetaCell, AnyItem>.init(cellNib: .init(nibName: String(describing: BetaCell.self), bundle: nil)) { cell, indexPath, itemIdentifier in
        let data: Beta = itemIdentifier.resolve()
        cell.button.setTitle(data.count.description, for: .normal)
    }
}

extension BetaCell: Dequeueing {
    static func dequeueCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: AnyItem) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: Self.registration, for: indexPath, item: item)
    }
    
}
