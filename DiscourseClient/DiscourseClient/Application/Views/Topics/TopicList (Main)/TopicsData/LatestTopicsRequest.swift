//
//  LatestTopicsRequest.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import Foundation

struct LatestTopicsRequest: APIRequest {

    typealias Response = LatestTopicsResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/latest.json"
    }
    
    var parameters: [String : String] {
        [:]
    }
    
    var body: [String : Any]{
        [:]
    }
    
    var headers: [String : String]{
        [:]
    }
 
}
