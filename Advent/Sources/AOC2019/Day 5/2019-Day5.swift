final class Day5: Day {
    private lazy var programValues: [Int] = {
        input.integers
    }()

    override func part1() -> String {
        ""
    }

    override func part2() -> String {
        ""
    }

    func process(memory: [Int]) -> ([Int], Int) {
        let intcode = IntCode(memory: memory, supportedOperations: [.add, .multiply, .get, .set, .halt])
        return intcode.run()
    }
}
