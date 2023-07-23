import UIKit

public protocol ItemProviding: Hashable {
    var reuseIdentifier: String { get }
}

public extension ItemProviding {
    var reuseIdentifier: String { String(reflecting: Self.self) }
}
