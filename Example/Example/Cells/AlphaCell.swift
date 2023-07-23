//
//  AlphaCell.swift
//  Example
//
//  Created by Ugur Bozkurt on 26/11/2022.
//

import UIKit
import CompositionalLayoutUtils

final class AlphaCell: UICollectionViewListCell {
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension AlphaCell: Registering {
    static var registration: UICollectionView.CellRegistration<AlphaCell, AnyItem> = UICollectionView.CellRegistration<AlphaCell, AnyItem>(cellNib: .init(nibName: String(describing: AlphaCell.self), bundle: nil)) { cell, indexPath, itemIdentifier in
        var config = cell.defaultContentConfiguration()
        let data: Alpha = itemIdentifier.resolve()
        config.text = data.title
        cell.contentConfiguration = config
        cell.contentView.backgroundColor = .red
    }
}

extension AlphaCell: Dequeueing {
    static func dequeueCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: AnyItem) -> UICollectionViewCell {
        return collectionView.dequeueConfiguredReusableCell(using: Self.registration, for: indexPath, item: item)
    }
}
