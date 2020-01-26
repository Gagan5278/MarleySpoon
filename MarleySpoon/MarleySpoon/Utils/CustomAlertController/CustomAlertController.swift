//
//  CustomAlertController.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/24.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit
class CustomAlertController {
    /// Show an alert to user from a view controller
    /// - Parameters:
    ///   - title: Title  String of the alert
    ///   - message: message string
    ///   - buttonTitle: button title as String
    ///   - onViewController: ViewController where alert need to be present
    ///   - callBack: Optional ann call back action on alert button click
    class func showUserAlert(with title : String, message : String, buttonTitle : String, onViewController : UIViewController, withCallback callBack :((UIAlertAction) -> Void)?)
    {
        //1. Create alert controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //2. add action to alert controller
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: callBack))
        //3. present on viewController
        onViewController.present(alertController, animated: true, completion: nil)
    }
}
