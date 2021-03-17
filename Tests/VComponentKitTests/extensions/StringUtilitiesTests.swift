import XCTest
import Foundation
@testable import VComponentKit

final class StringUtilitiesTests: XCTestCase {
    static var allTests = [
        ("testChunks", testChunks),
        ("testVProperties", testVProperties)
    ]

    func testChunks() throws {
        XCTAssertEqual("".chunks(ofLength: 1), [""])
        XCTAssertEqual("test".chunks(ofLength: 1), "test".map { String($0) })
        XCTAssertEqual("test".chunks(ofLength: 2), ["te", "st"])
        XCTAssertEqual("test".chunks(ofLength: 3), ["tes", "t"])
        XCTAssertEqual("test".chunks(ofLength: 4), ["test"])
        XCTAssertEqual("test".chunks(ofLength: 5), ["test"])
    }
    
    func testVProperties() throws {
        let randomNum = Int.random(in: 0...1000)
        let urlStr = "https://www.google.com"
        let url = URL(string: urlStr)!
        
        XCTAssertEqual(true.vEncoded, "1")
        XCTAssertEqual(false.vEncoded, "0")
        XCTAssertEqual(randomNum.vEncoded, "\(randomNum)")
        XCTAssertEqual(url.vEncoded, urlStr)
    }
}
