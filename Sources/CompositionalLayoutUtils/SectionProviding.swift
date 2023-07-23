import UIKit

public protocol SectionProviding: Hashable{
    func layout(_ sectionIndex: Int, _ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}
