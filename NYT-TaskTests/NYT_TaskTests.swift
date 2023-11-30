//
//  NYT_TaskTests.swift
//  NYT-TaskTests
//
//  Created by Abdul Qadar on 11/29/23.
//

import XCTest
@testable import NYT_Task

final class NYT_TaskTests: XCTestCase {

<<<<<<< Updated upstream
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

=======
    var mpNewsApi = MPNewsAPI()

    func testApiResponse() throws {
        try XCTSkipUnless(Reachability.isConnectedToNetwork(), "~~ No Internet connected ~~")

        // ~~ Mock data ~~
        let page = 0
        let period = 7
        var status: String?
        let expectedStatus = "OK"
        var responseError: Error?
        let expectation = expectation(description: expectedStatus)

        mpNewsApi.getNews(page: page, period: period) { (response) in
            switch response {
                case .success(let result):
                    debugPrint("Unit test completed")
                    status = result.status.lowercased()
                case.failure:
                    let error = NSError(domain: "Failed", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])
                    responseError = error
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(status, expectedStatus)
    }
>>>>>>> Stashed changes
}
