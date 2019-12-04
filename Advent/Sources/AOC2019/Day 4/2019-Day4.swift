import Nano
final class Day4: Day {
    lazy var rangeValues: Range<Int> = {
        let range = input.raw
            .components(separatedBy: "-")
            .compactMap { Int($0) }

        return range[0]..<range[1]
    }()

    override func part1() -> String {
        let n = numberOfUniquePasswords(within: rangeValues)
        return "\(n)"
    }

    override func part2() -> String {
        ""
    }

    func numberOfUniquePasswords(within range: Range<Int>) -> Int {
        range.count(where: isValid(password:))
    }

    func isValid(password: Int) -> Bool {
        let string = String(password)

        let zippedStrings = zip(
            Array(string),
            Array(string).dropFirst()
        )

        let hasRepeatDigit = zippedStrings.contains { $0 == $1 }

        let isInIncreasingOrder = zippedStrings.reduce(into: true) { isIncrementing, stringPair in
            isIncrementing = isIncrementing
                && Int(String(stringPair.0))! <= Int(String(stringPair.1))!
        }

        return string.count == 6
            && hasRepeatDigit
            && isInIncreasingOrder
    }
}
