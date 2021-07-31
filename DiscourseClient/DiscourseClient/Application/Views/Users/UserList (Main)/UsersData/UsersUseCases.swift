//
//  UserUseCases.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation

// MARK: UsersUseCases Protocols
// Usamos el protocolo para que el viewModel llame al protocolo
// UseCases va a ser una extension del DataManager, que a su vez, invocará al ApiSession
protocol UsersUseCases {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> Void)
    
}
