import Foundation

public extension CGPoint {
    func manhattanDistance(to p2: CGPoint) -> Int {
        let y = Int(self.y - p2.y)
        let x = Int(self.x - p2.x)

        return abs(x) + abs(y)
    }
}
