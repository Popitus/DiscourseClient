//
//  CategoriesRequest.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import Foundation

// MARK: CategoriesRequest class
class CategoriesRequest: APIRequest {
    
    typealias Response = CategoriesResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
