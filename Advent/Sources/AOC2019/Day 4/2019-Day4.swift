import EliteCore

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
        let n = numberOfUniquePasswords(within: rangeValues, shouldValidateRepeatedDigits: true)
        return "\(n)"
    }

    func numberOfUniquePasswords(within range: Range<Int>, shouldValidateRepeatedDigits: Bool = false) -> Int {
        range.count { isValid(password: $0, shouldValidateRepeatedDigits: shouldValidateRepeatedDigits) }
    }

    func isValid(password: Int, shouldValidateRepeatedDigits: Bool = false) -> Bool {
        let string = String(password)

        guard string.count == 6 else {
            return false
        }

        let zippedStrings = zip(
            Array(string),
            Array(string).dropFirst()
        )

        let isInIncreasingOrder = zippedStrings.reduce(into: true) { isIncrementing, stringPair in
            isIncrementing = isIncrementing
                && Int(String(stringPair.0))! <= Int(String(stringPair.1))!
        }

        guard isInIncreasingOrder else {
            return false
        }

        let repeatedDigits: [Pair<String>: Int] = zippedStrings
            .reduce(into: [:]) { result, strings in
                let isRepeated = strings.0 == strings.1

                if isRepeated {
                    let pair = Pair(String(strings.0), String(strings.1))
                    result[pair, default: 0] += 1
                }
            }

        let hasRepeatDigit = repeatedDigits.contains { $0.value >= 1 }

        guard hasRepeatDigit else {
            return false
        }

        let doesRepeatInLargerGroup = shouldValidateRepeatedDigits
            ? !(repeatedDigits.count { $0.value == 1 } >= 1)
            : false

        return !doesRepeatInLargerGroup
    }
}
