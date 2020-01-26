//
//  Constants.swift
//  MarleySpoon
//
//  Created by Gagan Vishal on 2020/01/25.
//  Copyright © 2020 Gagan Vishal. All rights reserved.
//

import Foundation
enum Constants {
    //size for thumbnail image
    
    enum Contentful_API_Auth_Constants {
        static let spaceid = "kk2bw5ojx476"
        static let access_token = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
        static let envoirnment = "master"
    }
    
    enum Contentful_URL {
        ///recipe list
        static let recipe_URL = "https://cdn.contentful.com/spaces/\(Contentful_API_Auth_Constants.spaceid)/environments/\(Contentful_API_Auth_Constants.envoirnment)/entries?content_type=recipe"
        ///circular image with height 200 and width 200 and radius 180
        static let thumbnail_Image_Append_URL = "?fit=thumb&f=center&h=150&w=150&r=180"
        ///provide full size image
        static let full_Image_Append_URL = "?fit=fill"
    }
    
    ///Constant messages string used in the app
    enum User_Messages {
        public static let serviceFailureErrorMessage = "Something went wrong. Unable to fetch list from server."
    }
    
    /// Network error title & message
    enum Internet_Availibility {
        public static let networkErrorTitle  = "No Internet Connectivity"
        public static let netowrkErrorMessage = "There is currently no Internet connection available.\n\nPlease check your connection and try again."
    }
}
