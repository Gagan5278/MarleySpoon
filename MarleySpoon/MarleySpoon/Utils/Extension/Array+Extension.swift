//
//  Array+Extension.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/27.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
extension Array where Element: Tags {
    
    /// returns comma sprated tags 
    func createHumanRedableString() -> String {
        return self.reduce([String](), { res, item in
            var arr = res
            arr.append(item.name?.capitalized ?? "")
            return arr
        }).joined(separator: " & ")
    }
}

