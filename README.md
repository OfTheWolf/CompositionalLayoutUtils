# CompositionalLayoutUtils

Build reusable multiple section layouts with UICollectionViewCompositionalLayout framework.

Your datasource should conform to Any types 

```swift
var dataSource: UICollectionViewDiffableDataSource<AnySection, AnyItem>

dataSource = .init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
    return collectionView.dequeueCell(collectionView, indexPath: indexPath, item: itemIdentifier)
}

```

### Your layout
```swift
var layout: UICollectionViewLayout {
    return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] index, _ in
        guard let section = self?.dataSource.sectionIdentifier(for: index) else { return nil }
        return section.layout
    })
}
```

### Sample section definition
```swift
struct MySection: SectionProviding {
    let id = UUID()
    
    func layout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3),
                                              heightDimension: .estimated(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40)
        return section
    }
}
```
and wrap to AnySection         
```swift
let mySection = AnySection(MySection())
```

### Create cells by conforming to Registering & Dequeueing

```swift
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
```

### Sample item definition
```swift
struct MyItem: ItemProviding {
    let title: String
}
```

and wrap to AnyItem         
```swift
let myItem = AnyItem(MyItem(title: "hello"))
```

### Register cells once before applying snapshot
collectionView.register(cell: AlphaCell.self, item: Alpha.self)
collectionView.register(cell: BetaCell.self, item: Beta.self)

### Prepare data and apply
```swift
let item = AnyItem(myItem)
let section = AnySection(mySection, items: [item])

var snap = NSDiffableDataSourceSnapshot<AnySection, AnyItem>()
snap.appendSections([section])
snap.appendItems(section.items, toSection: section)
dataSource.apply(snap)
```

Congrats 🎉🎉🎉
