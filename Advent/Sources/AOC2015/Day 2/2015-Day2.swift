
final class Day2: Day {
    private let dimensionRegex = Regex(pattern: #"(\d+)x(\d+)x(\d+)"#)

    override func part1() -> String {
        let dimensions: [Dimensions] = input.lines
            .compactMap { (line: Line) -> RegexMatch? in
                dimensionRegex.match(line.raw)
            }
            .map { dimensionMatch in
                Dimensions(
                    length: dimensionMatch.int(1) ?? 0,
                    width: dimensionMatch.int(2) ?? 0,
                    height: dimensionMatch.int(3) ?? 0
                )
            }

        let totalWrappingPaperRequired = dimensions
            .reduce(into: 0) { totalWrappingPaper, dimension in
                let wrappingPaperRequired = requiredWrappingPaper(dimensions: dimension)

                totalWrappingPaper += wrappingPaperRequired.wrappingPaper + wrappingPaperRequired.slack
            }

        return "\(totalWrappingPaperRequired)"
    }

    override func part2() -> String {
        ""
    }

    func requiredWrappingPaper(dimensions: Dimensions) -> (wrappingPaper: Int, slack: Int) {
        let areaForLengthWidth = dimensions.length * dimensions.width
        let areaForWidthHeight = dimensions.width * dimensions.height
        let areaForHeightLength = dimensions.height * dimensions.length

        let slack = min(areaForLengthWidth, areaForWidthHeight, areaForHeightLength)

        let wrappingPaper = [areaForLengthWidth, areaForWidthHeight, areaForHeightLength]
            .map { $0 * 2 }
            .sum()

        return (wrappingPaper: wrappingPaper, slack: slack)
    }
}

struct Dimensions {
    let length: Int
    let width: Int
    let height: Int
}
