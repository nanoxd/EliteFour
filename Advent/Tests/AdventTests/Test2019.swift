@testable import AOC2019
import XCTest

class Test2019: XCTestCase {
    func testDay1() {
        let d = Day1()
        measure {
            let (p1, p2) = d.run()
            XCTAssertEqual(p1, "3434390")
            XCTAssertEqual(p2, "5148724")
        }
    }

    func test_day1_part1_examples() {
        let d = Day1()
        XCTAssertEqual(d.fuelRequired(mass: 12.0), 2)
        XCTAssertEqual(d.fuelRequired(mass: 14.0), 2)
        XCTAssertEqual(d.fuelRequired(mass: 1969.0), 654)
        XCTAssertEqual(d.fuelRequired(mass: 100_756.0), 33583)
    }

    func test_day1_part2_examples() {
        let d = Day1()

        XCTAssertEqual(
            d.fuelRequired(for: d.fuelRequired(mass: 14.0)),
            2
        )

        XCTAssertEqual(
            d.fuelRequired(for: d.fuelRequired(mass: 1969.0)),
            966
        )

        XCTAssertEqual(
            d.fuelRequired(for: d.fuelRequired(mass: 100_756.0)),
            50346
        )
    }

    func testDay2() {
        let d = Day2()
        measure {
            let (p1, p2) = d.run()

            XCTAssertEqual(p1, "4570637")
            XCTAssertEqual(p2, "5485")
        }
    }

    func test_day2Part1_examples() {
        let d = Day2()

        let stream1 = d.process(program: [1, 0, 0, 0, 99])
        XCTAssertEqual(stream1, [2, 0, 0, 0, 99])

        let stream2 = d.process(program: [2, 3, 0, 3, 99])
        XCTAssertEqual(stream2, [2, 3, 0, 6, 99])

        let stream3 = d.process(program: [2, 4, 4, 5, 99, 0])
        XCTAssertEqual(stream3, [2, 4, 4, 5, 99, 9801])

        let stream4 = d.process(program: [1, 1, 1, 4, 99, 5, 6, 0, 99])
        XCTAssertEqual(stream4, [30, 1, 1, 4, 2, 5, 6, 0, 99])
    }

    func testDay3() {
        let d = Day3()
        measure {
            let (p1, p2) = d.run()

            XCTAssertEqual(p1, "1431")
            XCTAssertEqual(p2, "48012")
        }
    }

    func test_day3_regex() {
        let day = Day3()
        let input = """
        R75,D30,R83,U83,L12,D49,R71,U7,L72
        """

        let matches = day.regex.matches(in: input)

        XCTAssertEqual(matches.count, 9)

        let firstMatch = matches.first
        XCTAssertEqual(firstMatch?[1], "R")
        XCTAssertEqual(firstMatch?.int(2), 75)

        let middleMatch = matches[4]
        XCTAssertEqual(middleMatch[1], "L")
        XCTAssertEqual(middleMatch.int(2), 12)
    }

    func test_day3Part1_example1() {
        let day = Day3()

        let testInput = ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"]
            .map(day.parseLine(_:))

        let wire1 = testInput.first!
        let wire2 = testInput.last!
        let distance = wire1.intersects(wire: wire2)

        XCTAssertEqual(distance, 159)
    }

    func test_day3Part1_example2() {
        let day = Day3()

        let testInput = ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]
            .map(day.parseLine(_:))

        let wire1 = testInput.first!
        let wire2 = testInput.last!
        let distance = wire1.intersects(wire: wire2)

        XCTAssertEqual(distance, 135)
    }

    func test_day3Part2_example1() {
        let day = Day3()

        let testInput = ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"]
            .map(day.parseLine(_:))

        let wire1 = testInput.first!
        let wire2 = testInput.last!

        XCTAssertEqual(wire1.fewestCombinedSteps(to: wire2), 610)
    }

    func test_day3Part2_example2() {
        let day = Day3()

        let testInput = ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]
            .map(day.parseLine(_:))

        let wire1 = testInput.first!
        let wire2 = testInput.last!

        XCTAssertEqual(wire1.fewestCombinedSteps(to: wire2), 410)
    }

    func testDay4() {
        let d = Day4()
        measure {
            let (p1, p2) = d.run()

            XCTAssertEqual(p1, "1650")
            XCTAssertEqual(p2, "1129")
        }
    }

    func test_day4Part1_examples() {
        let day = Day4()
        XCTAssertTrue(day.isValid(password: 111_111))
        XCTAssertTrue(day.isValid(password: 122_345))
        XCTAssertFalse(day.isValid(password: 223_450))
        XCTAssertFalse(day.isValid(password: 123_789))

        XCTAssertEqual(
            day.numberOfUniquePasswords(within: 123_456..<123_467),
            1
        )
    }

    func test_day4Part2_examples() {
        let day = Day4()
        XCTAssertTrue(day.isValid(password: 112_233, shouldValidateRepeatedDigits: true))
        XCTAssertTrue(day.isValid(password: 111_122, shouldValidateRepeatedDigits: true))
        XCTAssertFalse(day.isValid(password: 123_444, shouldValidateRepeatedDigits: true))
    }

    func testDay5() {
        let d = Day5()
        measure {
            let (p1, p2) = d.run()

            XCTAssertEqual(p1, "9961446")
            XCTAssertEqual(p2, "742621")
        }
    }

    func test_day5_examples() {
        let day = Day5()

        XCTAssertEqual(
            day.process(memory: [3, 0, 4, 0, 99]).0,
            [0, 0, 4, 0, 99]
        )

        XCTAssertEqual(
            day.process(memory: [1002, 4, 3, 4, 33]).0,
            [1002, 4, 3, 4, 99]
        )

        XCTAssertEqual(
            day.process(
                memory: [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8],
                addingOperations: [.equals, .jumpIfTrue, .jumpIfFalse, .lessThan]
            ).0,
            [3, 9, 8, 9, 10, 9, 4, 9, 99, 0, 8]
        )
    }

    func testDay6() {
        let d = Day6()
        measure {
            let (p1, p2) = d.run()

            XCTAssertEqual(p1, "358244")
            XCTAssertEqual(p2, "")
        }
    }

    func test_day6Part1_example() {
        let day = Day6(rawInput: """
        COM)B
        B)C
        C)D
        D)E
        E)F
        B)G
        G)H
        D)I
        E)J
        J)K
        K)L
        """)

        XCTAssertEqual(day.part1(), "42")
    }

    func testDay7() {
        let d = Day7()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay8() {
        let d = Day8()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay9() {
        let d = Day9()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay10() {
        let d = Day10()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay11() {
        let d = Day11()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay12() {
        let d = Day12()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay13() {
        let d = Day13()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay14() {
        let d = Day14()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay15() {
        let d = Day15()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay16() {
        let d = Day16()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay17() {
        let d = Day17()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay18() {
        let d = Day18()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay19() {
        let d = Day19()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay20() {
        let d = Day20()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay21() {
        let d = Day21()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay22() {
        let d = Day22()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay23() {
        let d = Day23()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay24() {
        let d = Day24()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay25() {
        let d = Day25()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }
}
