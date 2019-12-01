/// https://adventofcode.com/2019/day/1
final class Day1: Day {
    /**
     The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually calculate the fuel needed for the mass of each module (your puzzle input), then add together all the fuel values.

     What is the sum of the fuel requirements for all of the modules on your spacecraft?
     */
    override func part1() -> String {
        let fuelRequiredForEachModule = input.lines.integers
            .map { fuelRequired(mass: Double($0)) }

        let totalFuelNeeded = fuelRequiredForEachModule.sum()

        return "\(totalFuelNeeded)"
    }

    override func part2() -> String {
        let fuelRequiredForEachModule = input.lines.integers
            .map { fuelRequired(for: fuelRequired(mass: Double($0))) }

        let totalFuelNeeded = fuelRequiredForEachModule.sum()

        return "\(totalFuelNeeded)"
    }

    public func fuelRequired(mass: Double) -> Int {
        Int((mass / 3).rounded(.down)) - 2
    }

    func fuelRequired(for fuel: Int) -> Int {
        var totalFuelRequired = fuel
        var addedFuelRequirements = fuel

        while totalFuelRequired >= 0 {
            let newFuelRequired = fuelRequired(mass: Double(totalFuelRequired))

            addedFuelRequirements += newFuelRequired >= 0
                ? newFuelRequired
                : 0

            totalFuelRequired = newFuelRequired
        }

        return addedFuelRequirements
    }
}
