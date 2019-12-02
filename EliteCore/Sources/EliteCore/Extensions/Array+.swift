public extension Array {
    /// Splits `self` into an array by size,
    /// - Parameter size: Size to split by.
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
