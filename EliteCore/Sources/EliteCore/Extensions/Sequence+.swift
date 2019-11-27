import Foundation

// MARK: - Sequence

public extension Sequence {
    /// Infinitely cycles through `self`
    var cycled: AnyIterator<Element> {
        var current = makeIterator()

        return AnyIterator {
            guard let result = current.next() else {
                current = self.makeIterator()
                return current.next()
            }

            return result
        }
    }
}

// MARK: - Sequence + Hashable

public extension Sequence where Element: Hashable {
    /// Creates a histogram of the number of times a value is seen in a Sequence
    func histogram() -> [Element: Int] {
        Dictionary(grouping: self, by: { $0 })
            .mapValues { $0.count }
    }

    /// Returns the unique elements in the Sequence, unordered.
    var unique: [Element] {
        Array(Set(self))
    }
}
