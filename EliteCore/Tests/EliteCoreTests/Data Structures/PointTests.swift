@testable import EliteCore
import XCTest

final class PointTests: XCTestCase {
    func test_manhattanDistance() {
        XCTAssertEqual(Point(x: 0, y: 0).manhattanDistance(to: .zero), 0)
        XCTAssertEqual(Point(x: 10, y: 15).manhattanDistance(to: .zero), 25)

        XCTAssertEqual(
            Point(x: 5, y: 2).manhattanDistance(to: Point(x: -5, y: -2)),
            14
        )

        XCTAssertEqual(
            Point(x: 1023, y: -521).manhattanDistance(to: Point(x: -364, y: 9003)),
            10911
        )
    }

    func test_applying_transform() {
        XCTAssertEqual(
            Point.zero.applying(translationX: 10, translationY: 8),
            Point(x: 10, y: 8)
        )

        XCTAssertEqual(
            Point(x: 12, y: 2).applying(translationX: 8, translationY: 0),
            Point(x: 20, y: 2)
        )

        XCTAssertEqual(
            Point(x: 1, y: 9).applying(translationX: -8, translationY: 20),
            Point(x: -7, y: 29)
        )
    }

    func test_addition() {
        XCTAssertEqual(Point.zero + Point(x: 3, y: 3), Point(x: 3, y: 3))
        XCTAssertEqual(Point(x: 10, y: 3) + Point(x: 3, y: 3), Point(x: 13, y: 6))
        XCTAssertEqual(Point(x: 1, y: -5) + Point(x: -3, y: -3), Point(x: -2, y: -8))
    }

    static var allTests = [
        ("test_manhattanDistance", test_manhattanDistance),
        ("test_applying_transform", test_applying_transform),
        ("test_addition", test_addition),
    ]
}
