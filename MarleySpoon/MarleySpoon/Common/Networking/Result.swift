//
//  Result.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}
