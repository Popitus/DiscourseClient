//
//  File.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation

// MARK: RemoteDataManager Class
// El que se encarga de hacer la llamada y retornar los success y/o failure
class RemoteDataManager {
    let session: SessionAPI = SessionAPI()
}

// MARK: RemoteDataManager Extensions -> UsersUseCases
extension RemoteDataManager: UsersUseCases {
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> Void) {
        let request: UsersRequest = UsersRequest() // -> Creamos la request
        session.request(request: request) { result in // -> desde el sessionAPI con la request
            completion(result)
        }
    }
    
}

// MARK: RemoteDataManager Extensions -> UserDetailUseCases
extension RemoteDataManager: UserDetailUseCases {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> Void) {
        let request: UserDetailRequest = UserDetailRequest(username: username)
        session.request(request: request) { result in
            completion(result)
        }
    }
    
    func updateUserName(userName: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> Void) {
        let request: UpdateUserNameRequest = UpdateUserNameRequest(userName: userName, name: name)
        session.request(request: request) { result in
            completion(result)
        }
    }
    

}
// MARK: RemoteDataManager Extensions -> TopicsUsesCases
extension RemoteDataManager: TopicsUsesCases {
    
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> Void) {
        let request: LatestTopicsRequest = LatestTopicsRequest()
        session.request(request: request, completion: completion)
    }
    
    
}

// MARK: RemoteDataManager Extensions -> TopicsDetailUsesCases
extension RemoteDataManager: TopicDetailUseCases {
    
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> Void) {
        let request: DeleteTopicRequest = DeleteTopicRequest(id: id)
        session.request(request: request, completion: completion)
    }
    
    func fetchDetailTopic(id: Int, completion: @escaping (Result<TopicDetailResponse?, Error>) -> ()) {
        let request: TopicDetailRequest = TopicDetailRequest(id: id)
        session.request(request: request, completion: completion)
    }
    
    
}
// MARK: RemoteDataManager Extensions -> CreateTopicUseCases
extension RemoteDataManager: CreateTopicUseCases {
    func createTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<CreateTopicResponse?, Error>) -> ()) {
        let request: CreateTopicRequest = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.request(request: request, completion: completion)
    }
}

// MARK: RemoteDataManager Extensions -> CategoriesUseCases
extension RemoteDataManager: CategoriesUseCases {

    
    func fethAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> Void) {
        let request: CategoriesRequest = CategoriesRequest()
        session.request(request: request, completion: completion)
    }
 
}

extension RemoteDataManager: CategoriesDetailUseCases {
    func fetchDetailCategories(id: Int, completion: @escaping (Result<CategoriesDetailResponse?, Error>) -> Void) {
        let request: CategoriesDetailRequest = CategoriesDetailRequest(id: id)
        session.request(request: request, completion: completion)
    }
}

extension RemoteDataManager: CreateCategorieUseCases {
    func createCategorie(name: String, color: String, textColor: String, completion: @escaping (Result<CreateCategorieResponse?, Error>) -> Void) {
        let request: CreateCategorieRequest = CreateCategorieRequest(name: name, color: color, textColor: textColor)
        session.request(request: request, completion: completion)
    }
    
    
}
