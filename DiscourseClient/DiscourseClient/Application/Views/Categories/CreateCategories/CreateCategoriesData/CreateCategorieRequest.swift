//
//  CreateCategorieRequest.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 28/7/21.
//

import Foundation

struct CreateCategorieRequest: APIRequest {
    
    typealias Response = CreateCategorieResponse
    
    let name: String
    let color: String
    let textColor: String
    
    init(name: String, color: String, textColor: String) {
        self.name = name
        self.color = color
        self.textColor = textColor
    }
    
    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "name" : name,
            "color" : color,
            "text_color" : textColor,
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    
    
}
