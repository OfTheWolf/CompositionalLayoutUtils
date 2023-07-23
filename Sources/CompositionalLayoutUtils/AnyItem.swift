import UIKit

public struct AnyItem: Hashable {
    public static func == (lhs: AnyItem, rhs: AnyItem) -> Bool {
        lhs.base == rhs.base
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(base)
    }

    private let base: AnyHashable
    public let reusableIdentifier: String

    public init<Item: ItemProviding>(_ base: Item) {
        self.base = base
        self.reusableIdentifier = base.reuseIdentifier
    }

    public func resolve<Item: ItemProviding>() -> Item {
        guard let base = base as? Item else { fatalError("Could not cast to \(String(reflecting: Item.self)). Expected \(reusableIdentifier).") }
        return base
    }
}
