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
        range.count { isValidFast(password: $0, shouldValidateRepeatedDigits: shouldValidateRepeatedDigits) }
    }

    func isValidFast(password: Int, shouldValidateRepeatedDigits: Bool = false) -> Bool {
        var repeatCount = 1
        var hasDouble = false
        var previousDigit = password % 10
        var password = password / 10

        while password != 0 {
            let digit = password % 10

            if digit > previousDigit {
                return false
            } else if digit == previousDigit {
                repeatCount += 1

                if !shouldValidateRepeatedDigits, repeatCount == 2 {
                    hasDouble = true
                }
            } else if digit < previousDigit {
                if shouldValidateRepeatedDigits, repeatCount == 2 {
                    hasDouble = true
                }

                repeatCount = 1
            }

            password = password / 10
            previousDigit = digit
        }

        return hasDouble
            || (shouldValidateRepeatedDigits ? repeatCount == 2 : false)
    }

    func isValid(password: Int, shouldValidateRepeatedDigits: Bool = false) -> Bool {
        let digits = password.digits

        guard digits.count == 6 else {
            return false
        }

        let zipped = zip(digits, digits.dropFirst())

        let isInIncreasingOrder = zipped.reduce(into: true) { isIncrementing, intPair in
            isIncrementing = isIncrementing
                && intPair.0 <= intPair.1
        }

        guard isInIncreasingOrder else {
            return false
        }

        let repeatedDigits: [Pair<Int>: Int] = zipped
            .reduce(into: [:]) { result, ints in
                let isRepeated = ints.0 == ints.1

                if isRepeated {
                    let pair = Pair(ints.0, ints.1)
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
