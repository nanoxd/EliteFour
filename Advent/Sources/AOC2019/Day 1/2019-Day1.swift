/// https://adventofcode.com/2019/day/1
final class Day1: Day {
    override func part1() -> String {
        ""
    }

    override func part2() -> String {
        ""
    }

    public func fuelRequired(mass: Double) -> Int {
        Int((mass / 3).rounded(.down)) - 2
    }
}
