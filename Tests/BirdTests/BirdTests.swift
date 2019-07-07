import XCTest
@testable import Bird

final class BirdTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Bird().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
