//
//  RecipeModel.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation

class Items : Decodable {
    var fields : [RecipeModel] = []
    enum Items: String, CodingKey {
        case items
        case includes
        enum Field: String, CodingKey {
            case fields
            case Asset
            case Entry
        }
        enum AssetsField: String,CodingKey {
            case fields
            case sys
        }
        enum EntryField: String, CodingKey {
            case fields
            case sys
        }
    }
    
    required init(from decoder: Decoder) throws {
        //1.
        let container = try decoder.container(keyedBy: Items.self)
        //2.
        var nestedConatinerItems = try container.nestedUnkeyedContainer(forKey: .items)
        while nestedConatinerItems.isAtEnd  == false {
            let fieldContiner = try nestedConatinerItems.nestedContainer(keyedBy: Items.Field.self)
            var model = try fieldContiner.decode(RecipeModel.self, forKey: .fields)
            try self.extractAssetURLIn(container, modelItem: &model)
            try self.extractTagsIn(container, modelItem: &model)
            self.fields.append(model)
        }
    }
    
    private func extractAssetURLIn(_ container: KeyedDecodingContainer<Items>,modelItem: inout RecipeModel) throws  {
        let nestedConatinerIncludes = try container.nestedContainer(keyedBy: Items.Field.self, forKey: .includes)
        var allItems = try nestedConatinerIncludes.nestedUnkeyedContainer(forKey: .Asset)
        while  allItems.isAtEnd  == false {
            let fieldSysContainer = try allItems.nestedContainer(keyedBy: Items.AssetsField.self)
            let photoAsset = try fieldSysContainer.decode(Asset.self, forKey:  .fields)
            let sysContainer = try fieldSysContainer.decode(Sys.self, forKey:  .sys)
            //cheeck for same id and assign image URL
            if sysContainer.id == modelItem.photo.sys.id {
                modelItem.photo.url = photoAsset.file.url
                break
            }
        }
    }
    
    private func extractTagsIn(_ container: KeyedDecodingContainer<Items>, modelItem: inout RecipeModel) throws  {
        let nestedConatinerIncludes = try container.nestedContainer(keyedBy: Items.Field.self, forKey: .includes)
        var allItems = try nestedConatinerIncludes.nestedUnkeyedContainer(forKey: .Entry)
        while  allItems.isAtEnd  == false {
            let fieldSysContainer = try allItems.nestedContainer(keyedBy: Items.EntryField.self)
            let chefAsset = try fieldSysContainer.decodeIfPresent(NameField.self, forKey:  .fields)
            let tagAsset = try fieldSysContainer.decodeIfPresent(NameField.self, forKey: .fields)
            let sysContainer = try fieldSysContainer.decode(Sys.self, forKey:  .sys)
            if  sysContainer.id == modelItem.chef?.sys?.id, let chefName = chefAsset?.name  {
                    modelItem.chef?.name = chefName
            }

            modelItem.tags?.forEach({ ( tag) in
                if tag.tags.id == sysContainer.id, let name = tagAsset?.name  {
                    tag.name = name
                }
            })
        }
    }
}
