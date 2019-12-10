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

    override func run() -> (String, String) {
        // Part 1
        let station = analyzeMap()
            .max { $0.value.count < $1.value.count }!

        let part1 = "\(station.value.count)"

        // Part 2

        let stationPoint = station.key
        var vaporizeList = [Point]()

        while vaporizeList.count < 200 {
            let remaining = map.filter { !vaporizeList.contains($0) }
            let visibleAsteroids = visible(in: remaining, for: stationPoint)
            vaporizeList.append(contentsOf: visibleAsteroids)
        }

        let number200 = vaporizeList[199]
        let part2 = "\(number200.x * 100 + number200.y)"

        return (part1, part2)
    }

    func analyzeMap() -> [Point: Set<Double>] {
        map.reduce(into: [Point: Set<Double>]()) { dict, point in
            let others = map.filter { $0 != point }

            let angleSet = others.reduce(into: Set<Double>()) { set, otherPoint in
                set.insert(point.angle(to: otherPoint))
            }

            dict[point] = angleSet
        }
    }

    func visible(in asteroidField: Set<Point>, for point: Point) -> [Point] {
        let angles = asteroidField.reduce(into: [Double: Point]()) { dict, asteroid in
            let angle = point.angle(to: asteroid)
            let current = dict[angle]
            if current == nil || point.manhattanDistance(to: current!) > point.manhattanDistance(to: asteroid) {
                dict[angle] = asteroid
            }
        }
        return angles.sorted { $0.key < $1.key }.map { $0.value }
    }
}
