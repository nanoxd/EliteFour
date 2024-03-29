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

    func test_histogram_displaysOccurrance() {
        let characters = ["Ash", "Misty", "Brock"]
        let letterOccurance = characters
            .flatMap { Array($0) }
            .histogram()

        print(letterOccurance)

        XCTAssertNil(letterOccurance["d"])
        XCTAssertEqual(letterOccurance["M"], 1)
        XCTAssertEqual(letterOccurance["s"], 2)
    }

    func test_unique_uniquesArrays() {
        let numbers = [1, 2, 1, 5, 10, 5]
        let uniqueNumbers = numbers.unique

        XCTAssertEqual(uniqueNumbers.count, 4)
    }

    static var allTests = [
        ("test_cycled_cyclesThroughSequence", test_cycled_cyclesThroughSequence),
        ("test_histogram_displaysOccurrance", test_histogram_displaysOccurrance),
        ("test_unique_uniquesArrays", test_unique_uniquesArrays),
    ]
}
