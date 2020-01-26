//
//  UIFont+Extension.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/26.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
import UIKit

enum CustomFont {
    case semibold
    case regular
    
    var fontNameString: String {
        switch self {
        case .semibold:
            return "AmericanTypewriter-Semibold"
        case .regular:
            return "AmericanTypewriter"
        }
    }
    
    /// Create a UIFont from given font name
    /// - Parameter size: CGFloat
    func font(with size: CGFloat) -> UIFont {
        return UIFont.init(name: self.fontNameString, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

