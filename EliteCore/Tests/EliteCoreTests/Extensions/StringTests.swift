@testable import EliteCore
import XCTest

final class StringTests: XCTestCase {
    func test_distance_betweenTwoIDs() {
        let firstID = "abcdef"
        let secondID = "afddef"

        XCTAssertEqual(firstID.distance(to: secondID), 2)
    }

    static var allTests = [
        ("test_distance_betweenTwoIDs", test_distance_betweenTwoIDs),
    ]
}
