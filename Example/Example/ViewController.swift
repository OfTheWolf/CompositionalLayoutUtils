//
//  ViewController.swift
//  Example
//
//  Created by Ugur Bozkurt on 19/11/2022.
//

import UIKit
import CompositionalLayoutUtils

class ViewController: UIViewController {

    var layout: UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] index, layoutEnv in
            guard let section = self?.dataSource.sectionIdentifier(for: index) else { return nil }

            return section.layout(index, layoutEnv)
        })
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<AnySection, AnyItem>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)

        collectionView.register(cell: AlphaCell.self, item: Alpha.self)
        collectionView.register(cell: BetaCell.self, item: Beta.self)

        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            print(itemIdentifier.reusableIdentifier)
            return collectionView.dequeueCell(indexPath: indexPath, item: itemIdentifier)
        }

        applySnap()
        
    }

    func applySnap() {
        var snap = NSDiffableDataSourceSnapshot<AnySection, AnyItem>()
        let sectionA = makeSectionA()
        snap.appendSections([sectionA])
        snap.appendItems(sectionA.items, toSection: sectionA)

        let sectionB = makeSectionB()
        snap.appendSections([sectionB])
        snap.appendItems(sectionB.items, toSection: sectionB)
        dataSource.apply(snap)
    }

    func makeSectionA() -> AnySection {
        let item1 = AnyItem(Alpha(title: "john"))
        let item2 = AnyItem(Beta(count: 1))
        let item3 = AnyItem(Beta(count: 2))
        let item4 = AnyItem(Beta(count: 3))
        let item5 = AnyItem(Alpha(title: "sarah"))
        let section = AnySection(SectionA(), items: [item1, item2, item3, item4, item5])
        return section
    }

    func makeSectionB() -> AnySection {
        let item1 = AnyItem(Alpha(title: "elsa"))
        let item2 = AnyItem(Beta(count: 4))
        let item3 = AnyItem(Alpha(title: "sofie"))
        let section = AnySection(SectionB(), items: [item1, item2, item3])
        return section
    }

}
