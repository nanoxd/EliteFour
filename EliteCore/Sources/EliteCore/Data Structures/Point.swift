import Foundation

/// Lightweight representation of an X and Y coordinate.
public struct Point: Equatable, Hashable {
    // MARK: - Points

    /// Origin
    public static let zero = Point(x: 0, y: 0)

    // MARK: - Properties

    public let x: Int
    public let y: Int

    /// Returns the absolute distance from a given point
    /// - Parameter other: The point to measure the absolute distance from
    public func manhattanDistance(to other: Point) -> Int {
        abs(other.x - x) + abs(other.y - y)
    }

    /// Returns a new `Point` with a translation applied on the X and Y axis.
    /// - Parameters:
    ///   - translationX: The amount to translate the `x` coordinate by.
    ///   - translationY: The amount to translate the `y` coordinate by.
    public func applying(translationX: Int, translationY: Int) -> Point {
        self + Point(x: translationX, y: translationY)
    }

    // MARK: - Operators

    public static func + (lhs: Point, rhs: Point) -> Point {
        Point(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }
}
