import Foundation

/// Space Image Format
final class Day8: Day {
    lazy var data: [Int] = {
        input.characters.compactMap { $0.wholeNumberValue }
    }()

    lazy var layers: [Layer] = {
        imageData(from: data, width: 25, height: 6)
    }()

    // To make sure the image wasn't corrupted during transmission, the Elves would
    // like you to find the layer that contains the fewest 0 digits. On that layer,
    // what is the number of 1 digits multiplied by the number of 2 digits?
    override func part1() -> String {
        let leastZeroDigitLayer = layers
            .min { layer1, layer2 in
                layer1.rawData.count(where: { $0 == 0 }) < layer2.rawData.count(where: { $0 == 0 })
            }!

        let countOfOnes = leastZeroDigitLayer.rawData.count { $0 == 1 }
        let countOfTwos = leastZeroDigitLayer.rawData.count { $0 == 2 }

        return "\(countOfOnes * countOfTwos)"
    }

    override func part2() -> String {
        ""
    }

    func imageData(from input: [Int], width: Int, height: Int) -> [Layer] {
        input
            .chunked(into: width * height)
            .map {
                Layer(
                    height: height,
                    width: width,
                    rawData: $0,
                    data: $0.chunked(into: width)
                )
            }
    }
}

struct Layer {
    let height: Int
    let width: Int
    var rawData: [Int]
    var data: [[Int]]
}
