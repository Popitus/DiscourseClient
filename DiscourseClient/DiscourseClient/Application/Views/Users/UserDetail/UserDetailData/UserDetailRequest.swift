//
//  UserDetailRequest.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 23/7/21.
//

import Foundation

class UserDetailRequest: APIRequest {
    
    typealias Response = UserDetailResponse
    
    let username: String
    init (username: String) {
        self.username = username
    }
    
    var method: Method {
        return .GET
    }
    var path: String {
        return "/users/\(username).json"
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
