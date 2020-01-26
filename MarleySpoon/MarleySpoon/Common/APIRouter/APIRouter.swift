//
//  APIRouter.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation

enum APIRouter {
    case recipeList
    case thumbnailImageFor(url: String)
    case fullSizeImageFor(url: String)
    
    //MARK:- Get url string
    var urlString : String {
        switch self {
        case .recipeList:
            return Constants.Contentful_URL.recipe_URL
        case .fullSizeImageFor(let urlString):
            return "https:" + urlString + Constants.Contentful_URL.full_Image_Append_URL
        case .thumbnailImageFor(let urlString):
            return "https:" + urlString + Constants.Contentful_URL.thumbnail_Image_Append_URL
        }
    }
    
    //MARK:- Create Request
    func asRequest() -> URLRequest {
        guard let url = URL(string: self.urlString) else {
            fatalError("invalid url string")
        }
        ///Create URL Request with given URL
        var urlRequest = URLRequest(url: url)
        ///add authentication token in header
        urlRequest.setValue("Bearer \(Constants.Contentful_API_Auth_Constants.access_token)", forHTTPHeaderField: "Authorization")
        ///return request
        return urlRequest
    }
    
}
