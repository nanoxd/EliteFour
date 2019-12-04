import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(EliteCoreTests.allTests),
            testCase(RegexTests.allTests),
            testCase(Tuple2Tests.allTests),
            testCase(SequenceTests.allTests),
            testCase(StringTests.allTests),
            testCase(PointTests.allTests),
        ]
    }
#endif
