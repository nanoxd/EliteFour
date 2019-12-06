import EliteCore

final class Day6: Day {
    lazy var orbits: [Pair<String>] = {
        input.rawLines.map {
            let components = $0.components(separatedBy: ")")
            return Pair(components[0], components[1])
        }
    }()

    lazy var orbitalMap: [String: Node<String>] = {
        var bodies = [String: Node<String>]()

        for orbit in orbits {
            let parent = orbit.first
            let child = orbit.second

            let parentNode: Node<String>

            if bodies.keys.contains(parent) {
                parentNode = bodies[parent]!
            } else {
                parentNode = Node(value: parent)
                bodies[parent] = parentNode
            }

            let childNode: Node<String>

            if bodies.keys.contains(child) {
                childNode = bodies[child]!
            } else {
                childNode = Node(value: child)
                bodies[child] = childNode
            }

            parentNode.children.append(childNode)
            childNode.parent = parentNode
        }

        return bodies
    }()

    override func part1() -> String {
        let numberOfOrbits = orbitalMap.keys.reduce(into: 0) { numberOfOrbits, key in
            var currentNode = orbitalMap[key]
            while currentNode?.parent != nil {
                numberOfOrbits += 1
                currentNode = currentNode?.parent
            }
        }

        return "\(numberOfOrbits)"
    }

    /// What is the minimum number of orbital transfers required to move from the object
    /// YOU are orbiting to the object SAN is orbiting? (Between the objects they are
    /// orbiting - not between YOU and SAN.)
    override func part2() -> String {
        let orbitalJumps = minimumOrbitalJumps(from: "YOU", to: "SAN")
        return "\(orbitalJumps)"
    }

    func minimumOrbitalJumps(from: String, to: String) -> Int {
        let fromParents = parents(for: from)
        let toParents = parents(for: to)

        guard let pair = firstCommonElement(from: fromParents, to: toParents) else {
            return 0
        }

        return pair.first + pair.second
    }

    func firstCommonElement(from lhs: [String], to rhs: [String]) -> Pair<Int>? {
        for (index1, value1) in lhs.enumerated() {
            for (index2, value2) in rhs.enumerated() where value1 == value2 {
                return Pair(index1, index2)
            }
        }

        return nil
    }

    func parents(for key: String) -> [String] {
        var current = orbitalMap[key]
        var parents: [String] = []

        while current?.parent != nil {
            parents.append(current!.parent!.value)
            current = current?.parent
        }

        return parents
    }
}

class Node<T> {
    weak var parent: Node?
    var value: T
    var children = [Node]()

    init(value: T) {
        self.value = value
    }
}
