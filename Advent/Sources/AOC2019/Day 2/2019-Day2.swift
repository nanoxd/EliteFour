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
        let desiredOutput = 19_690_720
        var nounVerbPair: (noun: Int, verb: Int)?

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
        let intcode = IntCode(memory: program, supportedOperations: [.add, .multiply, .halt])
        return intcode.run()
    }
}
