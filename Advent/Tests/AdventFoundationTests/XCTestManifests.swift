import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(AdventFoundationTests.allTests),
        ]
    }
#endif
