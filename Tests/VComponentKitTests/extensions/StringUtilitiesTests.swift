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
        
        XCTAssertEqual(true.vEncoded, "TRUE")
        XCTAssertEqual(false.vEncoded, "FALSE")
        XCTAssertEqual(randomNum.vEncoded, "\(randomNum)")
        XCTAssertEqual(url.vEncoded, urlStr)
    }
    
    func testVDuration() throws {
        let duration1 = VDuration(VDurationDay(weeks: 7))
        let duration2 = VDuration(VDurationDay(days: 15), VDurationTime(hours: 5, minutes: 0, seconds: 20))
        let duration3 = VDuration(VDurationTime(hours: 2))

        XCTAssertEqual(duration1.vEncoded, "P7W")
        XCTAssertEqual(duration2.vEncoded, "P15DT5H0M20S")
        XCTAssertEqual(duration3.vEncoded, "PT2H")
    }
}
