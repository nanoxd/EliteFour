import Foundation
import Nano

public extension String {
    /// Returns the number of differences between `self` and `str`.
    func distance(to str: String) -> Int {
        Array(zip(indices, str.indices))
            .count(where: { self[$0] != str[$1] })
    }

    /// Returns the common characters used between `self` and `str`.
    func intersection(with str: String) -> String {
        String(
            zip(indices, str.indices)
                .filter { self[$0] == str[$1] }
                .map { self[$0.0] }
        )
    }
}

// MARK: - StringProtocol

public extension StringProtocol {
    var digits: [Int] { compactMap { $0.wholeNumberValue } }
}

// MARK: - LosslessStringConvertible

public extension LosslessStringConvertible {
    var string: String { .init(self) }
}

// MARK: - String + Numeric

public extension Numeric where Self: LosslessStringConvertible {
    var digits: [Int] { string.digits }
}
