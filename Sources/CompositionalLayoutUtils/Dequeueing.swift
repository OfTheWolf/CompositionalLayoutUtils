//
//  Dequeueing.swift
//  
//
//  Created by Ugur Bozkurt on 26/11/2022.
//

import UIKit

public protocol Dequeueing {
    static func dequeueCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: AnyItem) -> UICollectionViewCell
}
