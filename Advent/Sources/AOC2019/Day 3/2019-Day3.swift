final class Day3: Day {
    let regex = Regex(pattern: #"([RDLU])(\d+)"#)

    lazy var wires: [Wire] = {
        input.lines.map { parseLine($0.raw) }
    }()

    override func part1() -> String {
        ""
    }

    override func part2() -> String {
        ""
    }

    func parseLine(_ string: String) -> Wire {
        let matches = regex.matches(in: string)

        let segments = matches.compactMap { match -> Wire.Segment? in
            guard
                let directionString = match[1],
                let direction = Wire.Direction(rawValue: directionString),
                let length = match.int(2) else {
                return nil
            }

            return Wire.Segment(direction: direction, length: length)
        }

        return Wire(segments: segments)
    }
}

struct Wire {
    struct Segment {
        let direction: Direction
        let length: Int

        var directionalLength: CGFloat {
            switch direction {
            case .left, .down:
                return -CGFloat(length)
            case .right, .up:
                return CGFloat(length)
            }
        }

        var transform: CGAffineTransform {
            switch direction {
            case .right, .left:
                return CGAffineTransform(translationX: directionalLength, y: 0)
            case .up, .down:
                return CGAffineTransform(translationX: 0, y: directionalLength)
            }
        }
    }

    enum Direction: Equatable, CaseIterable {
        case right
        case left
        case down
        case up

        init?(rawValue: String) {
            switch rawValue {
            case "R":
                self = .right
            case "L":
                self = .left
            case "D":
                self = .down
            case "U":
                self = .up
            default: return nil
            }
        }
    }

    var segments: [Segment]

    func breadcrumbs() -> [CGPoint] {
        segments
            .flatMap { segment in
                (0..<segment.length).replay(segment)
            }
            .reduce(into: [CGPoint.zero]) { points, segment in
                points.append(
                    points[points.endIndex - 1].byMoving(direction: segment.direction)
                )
            }
    }

    /// Returns the intersection point between `self` and `wire`.
    func intersects(wire: Wire) -> Int? {
        let path = breadcrumbs()

        return wire.breadcrumbs()
            .dropFirst()
            .filter { path.contains($0) }
            .map { $0.manhattanDistance }
            .min()
    }
}

extension Sequence {
    func replay<T>(_ replayer: @autoclosure () -> T) -> [T] {
        map { _ in replayer() }
    }
}

extension CGPoint {
    func byMoving(direction: Wire.Direction) -> CGPoint {
        switch direction {
        case .right: return applying(.init(translationX: 1, y: 0))
        case .left: return applying(.init(translationX: -1, y: 0))
        case .up: return applying(.init(translationX: 0, y: 1))
        case .down: return applying(.init(translationX: 0, y: -1))
        }
    }
}
