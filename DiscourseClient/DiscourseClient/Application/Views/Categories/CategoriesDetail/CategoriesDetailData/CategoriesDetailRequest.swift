//
//  CategoriesDetailRequest.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import Foundation

struct CategoriesDetailRequest: APIRequest {
    
    typealias Response = CategoriesDetailResponse
    
    let id: Int
    
    init(id: Int){
        self.id = id
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/c/\(id)/show.json"
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
