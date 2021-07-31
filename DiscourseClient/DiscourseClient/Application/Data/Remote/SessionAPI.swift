//
//  SessionAPI.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation


// SessionAPIError Enum
enum SessionAPIError: Error {
    case httpError(Int)
    case apiError(ApiError)
}

// APIError Struct
struct ApiError: Codable {
    let action: String?
    let errors: [String]?
}

// SessionAPI Class
final class SessionAPI {
    
    // Properties
    
    lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: configuration)
        
        return session
    }()
    
    // Functions
    
    func request<T: APIRequest> (request: T, completion: @escaping(Result<T.Response?, Error>) -> ()) {
        let request: URLRequest = request.requestWithBaseUrl()
        
        let task: URLSessionTask = session.dataTask(with: request) { data, response, error in
            
            //Error
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 && httpResponse.statusCode < 500{
                if let data: Data = data {
                    do {
                        let model: ApiError = try JSONDecoder().decode(ApiError.self, from: data)
                        DispatchQueue.main.async {
                            completion(.failure(SessionAPIError.apiError(model)))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(SessionAPIError.httpError(httpResponse.statusCode)))
                    }
                }
                return
            }
            
            //nos devuelve ok
            if let data: Data = data, data.count > 0 {
                do {
                    let model: T.Response = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            }
        }
        
        task.resume()
    }
}
