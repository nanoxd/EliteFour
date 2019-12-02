import EliteCore

final class Day2: Day {
    private lazy var programValues: [Int] = {
        input.integers
    }()

    override func part1() -> String {
        let program = process(program: programValues)

        return "\(program[0])"
    }

    override func part2() -> String {
        let desiredOutput = 19690720
        var nounVerbPair: (noun: Int, verb: Int)? = nil

        for noun in 20...99 where nounVerbPair == nil {
            for verb in 20...99 {
                var currentProgram = programValues
                currentProgram[1] = noun
                currentProgram[2] = verb

                let memory = process(program: currentProgram)
                if memory[0] == desiredOutput {
                    nounVerbPair = (noun: noun, verb: verb)
                }
            }
        }

        guard let pair = nounVerbPair else {
            fatalError("Pair should have been determined")
        }

        return "\(100 * pair.noun + pair.verb)"
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
