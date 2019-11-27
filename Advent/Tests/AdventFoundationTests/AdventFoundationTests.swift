@testable import AdventFoundation
import XCTest

final class AdventFoundationTests: XCTestCase {
    func testPairEquality() {
        let pair = Pair(1, 2)
        XCTAssertEqual(pair, Pair(1, 2))
    }

    static var allTests = [
        ("testPairEquality", testPairEquality),
    ]
}
