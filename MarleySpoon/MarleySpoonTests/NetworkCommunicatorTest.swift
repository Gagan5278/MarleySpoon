//
//  NetworkCommunicatorTest.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/26.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import MarleySpoon
class NetworkCommunicatorTest: XCTestCase {
    var networkCommunicator: NetworkCommunicator!

    override func setUp() {
        networkCommunicator = NetworkCommunicator()
    }

    override func tearDown() {
        networkCommunicator =  nil
    }

    //MARK:- Test Recipe List Fetch
    func testRecipeListFetch()
    {
        let expectationObeject = expectation(description: "Fetch Contributers")
        var fakeModel: Items?
        self.networkCommunicator.fetchRecipeList(value: Items.self) { (result) in
            switch result {
             case .success(let item):
                      fakeModel = item
             case .failure(_):
                break
            }
            expectationObeject.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotNil(fakeModel)
    }
}
