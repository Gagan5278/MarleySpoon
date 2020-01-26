//
//  ImageOperationTest.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/26.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import MarleySpoon
class ImageOperationTest: XCTestCase {

    var mockOperationQueue: OperationQueue!
    override func setUp() {
        mockOperationQueue = OperationQueue()
        mockOperationQueue.maxConcurrentOperationCount = 1    }

    override func tearDown() {
        mockOperationQueue = nil
    }
    //MARK:- test image download operation
    func testOperation() {
        let expectationObject = expectation(description: "Operation mock request")
        let operation = ImageOperation(indexPath: IndexPath(row: 0, section: 0), url: URL(string: FakeModel.fakeImageURLString)!)  //force wrap crash if URL is invalid
        operation.queuePriority = .normal
        var imageDownloaded: UIImage?  //we are expecting error from service
        operation.imageDownloadCompletionHandler = {(image, url,indexPath,error) in
            imageDownloaded = image
            expectationObject.fulfill()
        }
        mockOperationQueue.addOperation(operation)
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotNil(imageDownloaded)
    }

}
