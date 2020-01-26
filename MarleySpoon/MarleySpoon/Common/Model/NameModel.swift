//
//  NameModel.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation

protocol NameModel: Decodable {
    var id: String { get set }
}

protocol ChefModel: NameModel {
    var name: String { get set }
}

protocol TagModel: NameModel {
    var name: String { get set }
}
