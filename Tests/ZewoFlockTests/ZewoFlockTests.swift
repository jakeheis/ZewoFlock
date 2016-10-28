import XCTest
@testable import ZewoFlock

class ZewoFlockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ZewoFlock().text, "Hello, World!")
    }


    static var allTests : [(String, (ZewoFlockTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
