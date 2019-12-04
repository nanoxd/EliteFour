final class Day3: Day {
    let regex = Regex(pattern: #"([RDLU])(\d+)"#)

    lazy var wires: [Wire] = {
        input.lines.map { parseLine($0.raw) }
    }()

    override func part1() -> String {
        let distance = wires[0].intersects(wire: wires[1])

        return "\(distance ?? 0)"
    }

    override func part2() -> String {
        let fewestCombinedSteps = wires[0].fewestCombinedSteps(to: wires[1])
        return "\(fewestCombinedSteps ?? 0)"
    }

    func parseLine(_ string: String) -> Wire {
        let matches = regex.matches(in: string)

        let segments = matches.compactMap { match -> Wire.Segment? in
            guard
                let directionString = match[1],
                let direction = CardinalDirection(rawValue: directionString),
                let length = match.int(2) else {
                return nil
            }

            return Wire.Segment(direction: direction, length: length)
        }

        return Wire(segments: segments)
    }
}

struct HSegment {
    let y: Int
    let minX: Int
    let maxX: Int
    let wireIndex: Int

    let steps: Int
    let startX: Int
}

struct VSegment {
    let x: Int
    let minY: Int
    let maxY: Int
    let wireIndex: Int

    let steps: Int
    let startY: Int
}

func findIntersections(horizontalSegments: [HSegment], verticalSegments: [VSegment]) -> [Point] {
    var currentHorizontalSegments: [HSegment] = []
    var result: [Point] = []

    let horizontalSegments = horizontalSegments.sorted(by: { seg1, seg2 in
        seg1.minX > seg2.minX
    })

    let verticalSegments = verticalSegments.sorted(by: { seg1, seg2 in
        seg1.x > seg2.x
    })

    var currentHorizontalSegmentSlice = horizontalSegments[...]

    for verticalSegment in verticalSegments {
        let x = verticalSegment.x

        let segment = currentHorizontalSegmentSlice.first
        currentHorizontalSegmentSlice = currentHorizontalSegmentSlice.dropFirst()
    }

    return result
}

struct Wire {
    struct Segment {
        let direction: CardinalDirection
        let length: Int
    }

    var segments: [Segment]

    func breadcrumbs() -> [Point] {
        segments
            .lazy
            .flatMap { segment in
                (0..<segment.length).replay(segment)
            }
            .reduce(into: [Point.zero]) { points, segment in
                points.append(
                    points[points.endIndex - 1].byMoving(direction: segment.direction)
                )
            }
    }

    /// Returns the intersection point between `self` and `wire`.
    func intersects(wire: Wire) -> Int? {
        let path = Set(breadcrumbs())

        return Set(wire.breadcrumbs()).intersection(path)
            .lazy
            .map { $0.manhattanDistance(to: .zero) }
            .filter { $0 != 0 }
            .min()
    }

    func fewestCombinedSteps(to wire: Wire) -> Int? {
        let wirePath = breadcrumbs()
        let otherWirePath = wire.breadcrumbs()

        let shortestIntersection = Set(wirePath)
            .intersection(Set(otherWirePath))
            .lazy
            .map {
                wirePath.firstIndex(of: $0)! + otherWirePath.firstIndex(of: $0)!
            }
            .filter { $0 != 0 }
            .sorted()
            .first

        return shortestIntersection
    }
}

extension Sequence {
    func replay<T>(_ replayer: @autoclosure () -> T) -> [T] {
        map { _ in replayer() }
    }
}

extension CardinalDirection {
    init?(rawValue: String) {
        switch rawValue {
        case "R":
            self = .east
        case "L":
            self = .west
        case "D":
            self = .south
        case "U":
            self = .north
        default: return nil
        }
    }
}
