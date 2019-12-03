import Foundation

public extension CGPoint {
    var manhattanDistance: Int {
        abs(Int(x)) + abs(Int(y))
    }

    func manhattanDistance(to p2: CGPoint) -> Int {
        let y = Int(self.y - p2.y)
        let x = Int(self.x - p2.x)

        return abs(x) + abs(y)
    }
}
