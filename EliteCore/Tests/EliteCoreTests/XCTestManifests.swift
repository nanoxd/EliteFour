import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(EliteCoreTests.allTests),
            testCase(RegexTests.allTests),
        ]
    }
#endif
