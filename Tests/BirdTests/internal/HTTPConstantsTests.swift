import XCTest
@testable import Bird

final class HTTPConstantsTests: XCTestCase {
    func testContentTypeKey() {
        XCTAssert(HTTPConstants.Header.Keys.contentType == "Content-Type")
    }
    
    func testContentTypeValueApplicationJSON() {
        XCTAssert(HTTPConstants.Header.Values.ContentType.applicationJSON == "application/json")
    }
}

extension HTTPConstantsTests {
    static var allTests = [
        (String(describing: testContentTypeKey), testContentTypeKey),
        (String(describing: testContentTypeValueApplicationJSON), testContentTypeValueApplicationJSON)
    ]
}
