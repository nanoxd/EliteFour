final class Day5: Day {
    private lazy var programValues: [Int] = {
        input.integers
    }()

    override func part1() -> String {
        let diagnosticCode = process(memory: programValues, input: 1)
        return "\(diagnosticCode.1)"
    }

    override func part2() -> String {
        ""
    }

    func process(memory: [Int], input: Int = 0) -> ([Int], Int) {
        let intcode = IntCode(memory: memory, supportedOperations: [.add, .multiply, .get, .set, .halt])
        return intcode.run(input: input)
    }
}
