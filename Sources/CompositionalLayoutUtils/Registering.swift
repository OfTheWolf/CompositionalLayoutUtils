//
//  Registering.swift
//  
//
//  Created by Ugur Bozkurt on 26/11/2022.
//

import UIKit

public protocol Registering: UICollectionViewCell {
    static var registration: UICollectionView.CellRegistration<Self, AnyItem> { get }
}
