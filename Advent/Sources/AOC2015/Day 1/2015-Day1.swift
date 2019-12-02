final class Day1: Day {
    override func part1() -> String {
        String(determineNumberOfFloors(input.raw))
    }

    override func part2() -> String {
        var currentFloor = 0

        let firstBasementIndex = (Array(input.raw)
            .firstIndex(where: { character in
                if shouldGoUp(String(character)) {
                    currentFloor += 1
                } else {
                    currentFloor -= 1
                }

                return currentFloor == -1
        }) ?? 0) + 1

        return "\(firstBasementIndex)"
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
