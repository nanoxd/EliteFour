import Foundation

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
