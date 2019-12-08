import Foundation

/// Space Image Format
final class Day8: Day {
    lazy var data: String = {
        input.raw
    }()

    // To make sure the image wasn't corrupted during transmission, the Elves would
    // like you to find the layer that contains the fewest 0 digits. On that layer,
    // what is the number of 1 digits multiplied by the number of 2 digits?
    override func part1() -> String {
        ""
    }

    override func part2() -> String {
        ""
    }

    func imageData(from input: String, width: Int, height: Int) -> [Layer] {
        Array(input)
            .chunked(into: width * height)
            .map {
                Layer(
                    height: height,
                    width: width,
                    data: $0.chunked(into: width)
                        .map { ch -> [String] in [String(ch)] }
                )
            }
    }
}

struct Layer {
    let height: Int
    let width: Int
    var data: [[String]]
}
