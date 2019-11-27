public typealias Pair<T> = Tuple2<T, T>

// MARK: - Tuple2

public struct Tuple2<A, B> {
    public let first: A
    public let second: B
    public init(_ first: A, _ second: B) {
        self.first = first
        self.second = second
    }
}

// MARK: Equatable

extension Tuple2: Equatable where A: Equatable, B: Equatable {}

// MARK: Hashable

extension Tuple2: Hashable where A: Hashable, B: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(first)
        hasher.combine(second)
    }
}
