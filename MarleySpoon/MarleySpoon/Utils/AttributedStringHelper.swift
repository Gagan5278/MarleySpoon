//
//  Extension+String.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/26.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

class AttributedStringHelper {
    /// Create an
    /// - Parameters:
    ///   - titleString: String Title
    ///   - descrptionString: String Description
    ///   - titleFont: Font for title
    ///   - titleTextColor: Color for title. Default is white
    ///   - descriptionFont: Font for decsription
    ///   - descriptionTextColor: Text Color for description. Default is white
    class func createAttributedString(from titleString: String, descriptionString: String, titleFont: UIFont,titleTextColor: UIColor = .white, descriptionFont: UIFont, descriptionTextColor: UIColor = .white) -> NSAttributedString
    {
        //1.
        let accountHeaderAttributes = [
            NSAttributedString.Key.foregroundColor : titleTextColor as Any,
            NSAttributedString.Key.font : titleFont as Any,
        ]
        //2.
        let accountBalanceAttributes = [
            NSAttributedString.Key.foregroundColor : descriptionTextColor  as Any,
            NSAttributedString.Key.font : descriptionFont  as Any
            ] as [NSAttributedString.Key : Any]
        
        //3.
        let firstAttrString = NSAttributedString(string: titleString, attributes: accountHeaderAttributes)
        //4.
        let secondAttrString = NSMutableAttributedString(string: descriptionString, attributes: accountBalanceAttributes)
        //5.
        let combination = NSMutableAttributedString()
        combination.append(firstAttrString)
        combination.append(secondAttrString)
        return combination
    }
}
