final class Day1: Day {
    override func part1() -> String {
        String(determineNumberOfFloors(input.raw))
    }

    override func part2() -> String {
        ""
    }

    func shouldGoUp(_ str: String) -> Bool {
        str == "("
    }

    func determineNumberOfFloors(_ characters: String) -> Int {
        Array(characters).reduce(into: 0) { floors, character in
            if shouldGoUp(String(character)) {
                floors += 1
            } else {
                floors -= 1
            }
        }
    }
}
