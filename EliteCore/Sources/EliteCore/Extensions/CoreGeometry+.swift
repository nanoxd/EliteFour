import Foundation

public extension CGPoint {
    var manhattanDistance: Int {
        manhattanDistance(to: .zero)
    }

    func manhattanDistance(to p2: CGPoint) -> Int {
        let x = Int(self.x - p2.x)
        let y = Int(self.y - p2.y)

        return abs(x) + abs(y)
    }
}
