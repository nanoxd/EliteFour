import Foundation
import Nano

public extension String {
    /// Returns the number of differences between `self` and `str`.
    func distance(to str: String) -> Int {
        Array(zip(indices, str.indices))
            .count(where: { self[$0] != str[$1] })
    }
}
