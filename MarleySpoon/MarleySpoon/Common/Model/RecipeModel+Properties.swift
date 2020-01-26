//
//  RecipeModel+Properties.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation

class RecipeModel: Decodable {
    let title: String
    let description: String
    var chef: Chef?
    var tags: [Tags]?
    var photo: Photo
    enum Field: String, CodingKey {
        case title
        case description
        case chef
        case tags
        case photo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Field.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.chef = try container.decodeIfPresent(Chef.self, forKey: .chef)
        self.tags = try container.decodeIfPresent([Tags].self, forKey: .tags)
        self.photo = try container.decode(Photo.self, forKey: .photo)
    }
}


protocol nameField: Decodable {
    var name: String? {set get}
}

class Photo: Decodable {
    let sys: Sys
    var url: String?
}

class Chef: Decodable, nameField {
    var name: String?
    let sys: Sys?
}

class Tags: Decodable, nameField {
    var name: String?
    let tags: Sys
    enum CodingKeys: String, CodingKey {
        case sys
        case fields
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tags  = try container.decode(Sys.self, forKey: .sys)
    }
}

class Sys: Decodable {
    let type: String?
    let linkType: String?
    let id: String
}

class File: Decodable {
    let fileName: String
    let url: String
}

class Asset: Decodable {
    let file: File
    enum AssetCodingKeys: String, CodingKey {
        case file
        case sys
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AssetCodingKeys.self)
        self.file = try container.decode(File.self, forKey: .file)
    }
}

class NameField: Decodable {
    let name: String?
}

