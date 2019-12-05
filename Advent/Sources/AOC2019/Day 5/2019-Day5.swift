final class Day5: Day {
    private lazy var programValues: [Int] = {
        input.integers
    }()

    override func part1() -> String {
        let diagnosticCode = process(memory: programValues, input: 1)
        return "\(diagnosticCode.1)"
    }

    override func part2() -> String {
        let diagnosticCode = process(
            memory: programValues,
            addingOperations: [.equals, .jumpIfFalse, .jumpIfTrue, .lessThan],
            input: 5
        )

        return "\(diagnosticCode.1)"
    }

    func process(memory: [Int], addingOperations ops: Set<IntCode.Op> = [], input: Int = 0) -> ([Int], Int) {
        let operations = ops.union([IntCode.Op.add, .multiply, .get, .set, .halt])
        let intcode = IntCode(memory: memory, supportedOperations: operations)
        return intcode.run(input: input)
    }
}
