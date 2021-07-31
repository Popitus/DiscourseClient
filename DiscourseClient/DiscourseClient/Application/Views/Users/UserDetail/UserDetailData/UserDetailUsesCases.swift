//
//  UserDetailUsesCases.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 23/7/21.
//

import Foundation

protocol UserDetailUseCases {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> Void)
    func updateUserName(userName: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> Void)
}
