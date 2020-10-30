import XCTest
@testable import Networker

final class NetworkerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let instance = Networker.shared
        XCTAssertNotNil(instance, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
