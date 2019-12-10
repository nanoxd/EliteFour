import EliteCore
import Foundation

/// Monitoring Station
final class Day10: Day {
    typealias StarMap = Set<Point>

    lazy var map: StarMap = {
        Set(
            input.lines.enumerated().map { lineIndex, line in
                line.characters.enumerated().compactMap { charIndex, char -> Point? in
                    guard char == "#" else {
                        return nil
                    }

                    return Point(x: charIndex, y: lineIndex)
                }
            }
            .flatMap { $0 }
        )
    }()

    /// Find the best location for a new monitoring station.
    /// How many other asteroids can be detected from that location?
    override func part1() -> String {
        let result = analyzeMap().map { $0.value.count }.max()!

        return "\(result)"
    }

    override func part2() -> String {
        ""
    func analyzeMap() -> [Point: Set<Double>] {
        map.reduce(into: [Point: Set<Double>]()) { dict, point in
            let others = map.filter { $0 != point }

            let angleSet = others.reduce(into: Set<Double>()) { set, otherPoint in
                set.insert(point.angle(to: otherPoint))
            }

            dict[point] = angleSet
        }
    }
}
