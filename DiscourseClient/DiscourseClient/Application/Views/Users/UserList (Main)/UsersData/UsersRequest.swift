//
//  UsersRequest.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation

// MARK: UsersRequest class
class UsersRequest: APIRequest {
    
    // La response va a ser UsersResponse
    typealias Response = UsersResponse

    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/directory_items.json"
    }
    
    var parameters: [String : String] {
        return ["period":"all"]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
