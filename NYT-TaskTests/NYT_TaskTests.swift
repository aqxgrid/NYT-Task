//
//  NYT_TaskTests.swift
//  NYT-TaskTests
//
//  Created by Abdul Qadar on 11/29/23.
//

import XCTest
@testable import NYT_Task

final class NYT_TaskTests: XCTestCase {

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
}
