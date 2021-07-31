//
//  DataManager.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation
class DataManager {
    let remoteDataManager: RemoteDataManager
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
}

// MARK: Extensions DataManager -> UsersUseCases
extension DataManager: UsersUseCases {
    
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> Void) {
        remoteDataManager.fetchAllUsers(completion: completion)
    }
    
}

// MARK: Extensions DataManager -> UsersDetailUseCases
extension DataManager: UserDetailUseCases {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> Void) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }
    func updateUserName(userName: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> Void) {
        remoteDataManager.updateUserName(userName: userName, name: name, completion: completion)
    }
}
// MARK: Extensions DataManager -> TopicsUsesCases
extension DataManager: TopicsUsesCases {
    
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> Void) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

// MARK: Extensions DataManager -> TopicDetailUseCases
extension DataManager: TopicDetailUseCases {
    
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> Void) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
    
    func fetchDetailTopic(id: Int, completion: @escaping (Result<TopicDetailResponse?, Error>) -> ()) {
        remoteDataManager.fetchDetailTopic(id: id, completion: completion)
    }
    
    
}
// MARK: Extensions DataManager -> CreateTopicUseCases
extension DataManager: CreateTopicUseCases {
    func createTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<CreateTopicResponse?, Error>) -> ()) {
        remoteDataManager.createTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
}

// MARK: Extensions DataManager -> CategoriesUseCases
extension DataManager: CategoriesUseCases {
    
    func fethAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> Void) {
        remoteDataManager.fethAllCategories(completion: completion)
    }
    
}

extension DataManager: CategoriesDetailUseCases {
    func fetchDetailCategories(id: Int, completion: @escaping (Result<CategoriesDetailResponse?, Error>) -> Void) {
        remoteDataManager.fetchDetailCategories(id: id, completion: completion)
    }
}

extension DataManager: CreateCategorieUseCases {
    func createCategorie(name: String, color: String, textColor: String, completion: @escaping (Result<CreateCategorieResponse?, Error>) -> Void) {
        remoteDataManager.createCategorie(name: name, color: color, textColor: textColor, completion: completion)
    }
    
    
}




