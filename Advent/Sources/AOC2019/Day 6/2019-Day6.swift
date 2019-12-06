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

    override func part2() -> String {
        ""
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
