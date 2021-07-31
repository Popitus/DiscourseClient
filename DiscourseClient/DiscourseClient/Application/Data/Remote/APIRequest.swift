//
//  APIRequest.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation

// MARK: APIRequest enums
enum Method: String{
    case GET
    case POST
    case PUT
    case DELETE
}

// MARK: APIRequest protocols
protocol APIRequest {
    
    associatedtype Response : Codable // Todas las response tienen que ser Codable para poder parsearlas
    var method: Method { get }
    var path: String { get }
    var parameters: [String:String] { get }
    var body: [String:Any] { get }
    var headers: [String:String] { get }
}

// MARK: APIRequest extensions
extension APIRequest {
    
    // Properties
    var apiURL: String {
        return "https://mdiscourse.keepcoding.io"
    }
    
    var baseURL: URL {
        guard let baseURL: URL = URL(string: apiURL) else {
            fatalError("URL not valid")
        }
        return baseURL
    }
    
    // Functions
    func requestWithBaseUrl() -> URLRequest {
        //Definimos cual va a ser la url
        let url:URL = baseURL.appendingPathComponent(path) // Añadiendo lo que tengamos en el APIRequest
        //Aqui tendriamos www.google.com/search
        
        //Si tiene parámetros
        
        guard var components:URLComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Not able to create components")
        }
        
        if !parameters.isEmpty {
            //components.queryItems = parameters.map{ URLQueryItem(name: $0, value: $1) }
            components.queryItems = parameters.map{ key, value in URLQueryItem(name: key, value: value) }
        }
        
        guard let finalUrl = components.url else {
            fatalError("Unable to get final url")
        }
        //Aqui tendriamos www.google.com/search?q=hola
        
        var request:URLRequest = URLRequest(url: finalUrl)
        
        request.httpMethod = method.rawValue
        
        if !body.isEmpty{
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        //headers
        
        //content-type
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //api-key
        request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
        //api-username
        request.addValue("che1404", forHTTPHeaderField: "Api-Username")
        
        return request
    }
}
