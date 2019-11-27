@testable import EliteCore
import XCTest

final class StringTests: XCTestCase {
    func test_distance_betweenTwoIDs() {
        let firstID = "abcdef"
        let secondID = "afddef"

        XCTAssertEqual(firstID.distance(to: secondID), 2)
    }

    func test_intersection() {
        let firstID = "abcdef"
        let secondID = "abcdfs"

        XCTAssertEqual(firstID.intersection(with: secondID), "abcd")
    }

    static var allTests = [
        ("test_distance_betweenTwoIDs", test_distance_betweenTwoIDs),
        ("test_intersection", test_intersection),
    ]
}
