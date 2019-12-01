@testable import AOC2019
import XCTest

class Test2019: XCTestCase {
    func testDay1() {
        let d = Day1()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "3434390")
        XCTAssertEqual(p2, "5148724")
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
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay3() {
        let d = Day3()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay4() {
        let d = Day4()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay5() {
        let d = Day5()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
    }

    func testDay6() {
        let d = Day6()
        let (p1, p2) = d.run()

        XCTAssertEqual(p1, "")
        XCTAssertEqual(p2, "")
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
