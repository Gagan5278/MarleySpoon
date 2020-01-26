//
//  CustomAlertControllerTest.swift
//  MarleySpoonTests
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import XCTest
@testable import MarleySpoon
class CustomAlertControllerTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    //MARK:- Alert Test
    func testCustomAlert() {
        if let rootController =  UIApplication.shared.windows.first?.rootViewController {
            CustomAlertController.showUserAlert(with: "Title", message: "message", buttonTitle: "OK", onViewController: rootController, withCallback: self.okButtonAlertAction(action:))
        }
    }
    
    fileprivate func okButtonAlertAction(action: UIAlertAction)
    {
        print("OK Button Pressed")
    }

}
