import UIKit

public struct AnySection: Hashable {
    public static func == (lhs: AnySection, rhs: AnySection) -> Bool {
        lhs.base == rhs.base
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(base)
    }

    private let base: AnyHashable
    public let items: [AnyItem]
    
    public let layout: (_ sectionIndex: Int, _ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection

    public init<Section: SectionProviding>(_ base: Section, items: [AnyItem]) {
        self.base = base
        self.items = items
        self.layout = base.layout
    }

    public func resolve<Section: SectionProviding>() -> Section? {
        guard let base = base as? Section else { return nil }
        return base
    }
}
