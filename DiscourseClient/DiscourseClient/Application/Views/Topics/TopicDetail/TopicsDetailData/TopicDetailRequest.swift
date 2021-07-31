//
//  TopicDetailRequest.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import Foundation

struct TopicDetailRequest: APIRequest {
    
    typealias Response = TopicDetailResponse
    
    let id: Int
    
    init(id: Int){
        self.id = id
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/t/\(id).json"
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
