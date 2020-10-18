import Foundation
import XCTest
@testable import VComponentKit

final class VComponentTests: XCTestCase {
    static var allTests = [
        ("testVComponent", testVComponent),
    ]

    private struct TestValue: VPropertyEncodable {
        var parameters: [(String, [String])] = [("SOMEPARAM", ["SOMEARG"])]
        var vEncoded: String = "somevalue"
    }

    private struct TestComponent: VComponent {
        var component: String = "TEST"
        var properties: [VContentLine?] = [
            .line("SOMEKEY", TestValue()),
            .line("ANOTHERKEY", "anothervalue"),
            .line("ANUMBER", 42),
            .line("AURL", URL(string: "https://en.wikipedia.org")!)
        ]
    }

    func testVComponent() {
        XCTAssertEqual(TestComponent().vEncoded, [
            "BEGIN:TEST",
            "SOMEKEY;SOMEPARAM=SOMEARG:somevalue",
            "ANOTHERKEY:anothervalue",
            "ANUMBER:42",
            "AURL:https://en.wikipedia.org",
            "END:TEST"
        ].map { "\($0)\r\n" }.joined())
    }
}
