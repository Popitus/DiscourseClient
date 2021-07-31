//
//  UpdateUserRequest.swift
//  DiscourseClient
//
//  Created by MacAMD on 23/7/21.
//

import Foundation

class UpdateUserNameRequest: APIRequest {
    
    typealias Response = UpdateUserNameResponse
    
    let userName: String
    var name: String
    
    init(userName: String, name: String) {
        self.userName = userName
        self.name = name
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "users/\(userName)"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["name": name]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    
}
