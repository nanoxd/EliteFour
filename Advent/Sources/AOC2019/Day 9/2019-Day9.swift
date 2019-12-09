/// Sensor Boost
final class Day9: Day {
    lazy var programValues: [Int] = {
        input.integers
    }()

    /// Once your Intcode computer is fully functional, the BOOST
    /// program should report no malfunctioning opcodes when run
    /// in test mode; it should only output a single value, the BOOST
    /// keycode. What BOOST keycode does it produce?
    override func part1() -> String {
        let processedMemory = process(program: programValues, input: [1])
        return "\(processedMemory.outputs.first ?? 0)"
    }

    override func part2() -> String {
        let processedMemory = process(program: programValues, input: [2])
        return "\(processedMemory.outputs.first ?? 0)"
    }

    func process(program: [Int], input: [Int]) -> (outputs: [Int], termination: Int) {
        let computer = IntCode2(memory: program, inputs: input)

        return computer.executeUntilTermination()
    }
}
