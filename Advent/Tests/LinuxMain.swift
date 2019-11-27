import XCTest

import AdventFoundationTests
import AdventTests

var tests = [XCTestCaseEntry]()
tests += AdventTests.allTests()
tests += AdventFoundationTests.allTests()
XCTMain(tests)
