import EliteCore

final class Day2: Day {
    override func part1() -> String {
        ""
    }

    override func part2() -> String {
        ""
    }

    func process(program: [Int]) -> [Int] {
        var stream = program
        var currentIndex = 0
        var chunks: [[Int]] = []
        var shouldHalt = false

        while !shouldHalt {
            chunks = stream.chunked(into: 4)
            let currentSlice = chunks[currentIndex]
            currentIndex += 1

            guard let opcode = currentSlice.first.flatMap({ OpcodeIndicator(rawValue: $0) }) else {
                continue
            }

            switch opcode {
            case .add:
                let index1 = currentSlice[1]
                let index2 = currentSlice[2]
                let registerIndex = currentSlice[3]

                let value = stream[index1] + stream[index2]
                stream[registerIndex] = value
            case .multiply:
                let index1 = currentSlice[1]
                let index2 = currentSlice[2]
                let registerIndex = currentSlice[3]

                let value = stream[index1] * stream[index2]
                stream[registerIndex] = value
            case .halt:
                shouldHalt = true
            }
        }

        return stream
    }
}

enum OpcodeIndicator: Int {
    case add = 1
    case multiply = 2
    case halt = 99
}
