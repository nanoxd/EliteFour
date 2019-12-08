/// Amplification Circuit
final class Day7: Day {
    lazy var ampControllerSoftware: [Int] = {
        input.integers
    }()

    /// Try every combination of phase settings on the amplifiers.
    /// What is the highest signal that can be sent to the thrusters?
    override func part1() -> String {
        var highest = 0
        permuteWirth(values: [0, 1, 2, 3, 4], count: 4) { phaseSettings in
            let result = calculateSolution1(phaseSettings: phaseSettings, program: ampControllerSoftware)

            if result > highest {
                highest = result
            }
        }

        return "\(highest)"
    }

    override func part2() -> String {
        var highest = 0

        permuteWirth(values: [5, 6, 7, 8, 9], count: 4) { phaseSettings in
            let result = calculateSolution2(phaseSettings: phaseSettings, program: ampControllerSoftware)

            if result > highest {
                highest = result
            }
        }

        return "\(highest)"
    }

    func calculateSolution1(phaseSettings: [Int], program: [Int]) -> Int {
        var totalMaximumOutput = 0

        for input in phaseSettings {
            totalMaximumOutput = IntCode2(memory: program, inputs: [input, totalMaximumOutput])
                .executeUntilTermination()
                .outputs
                .max()!
        }

        return totalMaximumOutput
    }

    func calculateSolution2(phaseSettings: [Int], program: [Int]) -> Int {
        let computers = phaseSettings.map {
            IntCode2(memory: program, inputs: [$0])
        }

        computers[0].inputs.append(0)
        var latestOuputFromLastComputer = 0
        var computerIndex = 0

        while true {
            let result = computers[computerIndex].step()

            if result.termination != nil {
                return latestOuputFromLastComputer
            }

            guard let output = result.output else { fatalError() }

            if computerIndex == computers.count - 1 {
                latestOuputFromLastComputer = output
            }

            computerIndex += 1
            computerIndex %= computers.count
            computers[computerIndex].inputs.append(output)
        }
    }

    // Taken from swift-algo-club Combinatorics
    func permuteWirth<T>(values: [T], count: Int, action: ([T]) -> Void) {
        if count == 0 {
            action(values)
        } else {
            var values = values
            permuteWirth(values: values, count: count - 1, action: action)

            for i in 0..<count {
                values.swapAt(i, count)
                permuteWirth(values: values, count: count - 1, action: action)
                values.swapAt(i, count)
            }
        }
    }
}
