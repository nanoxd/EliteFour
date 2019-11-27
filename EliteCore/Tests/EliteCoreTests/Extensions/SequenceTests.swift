@testable import EliteCore
import XCTest

final class SequenceTests: XCTestCase {
    func test_cycled_cyclesThroughSequence() {
        let numbers = [1, 2]
        let cycledNumbers = numbers.cycled

        XCTAssertEqual(cycledNumbers.next(), 1)
        XCTAssertEqual(cycledNumbers.next(), 2)
        XCTAssertEqual(cycledNumbers.next(), 1)
        XCTAssertEqual(cycledNumbers.next(), 2)
    }

    static var allTests = [
        ("test_cycled_cyclesThroughSequence", test_cycled_cyclesThroughSequence),
    ]
}
