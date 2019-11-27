@testable import EliteCore
import XCTest

final class Tuple2Tests: XCTestCase {
    func test_equatable_isEqual() {
        let pair = Pair(1, 2)
        XCTAssertEqual(pair, Pair(1, 2))
    }

    static var allTests = [
        ("test_equatable_isEqual", test_equatable_isEqual),
    ]
}
