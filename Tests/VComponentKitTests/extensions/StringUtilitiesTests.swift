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
        let uuidStr = "7E52D3BF-2CCB-4DC2-A91A-7E2ABF63A6C1"
        let uuid = UUID(uuidString: uuidStr)!
        let url = URL(string: urlStr)!
        
        // Boolean
        XCTAssertEqual(true.vEncoded, "TRUE")
        XCTAssertEqual(false.vEncoded, "FALSE")
        
        // Int
        XCTAssertEqual(randomNum.vEncoded, "\(randomNum)")
        
        // URL
        XCTAssertEqual(url.vEncoded, urlStr)
        
        XCTAssertEqual(uuid.vEncoded, uuidStr)
    }
}
