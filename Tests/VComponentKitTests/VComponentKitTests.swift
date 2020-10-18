import XCTest
@testable import VComponentKit

final class VComponentKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(VComponentKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
