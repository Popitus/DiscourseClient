//
//  CreateTopicUseCases.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import Foundation

protocol CreateTopicUseCases {
    func createTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<CreateTopicResponse?, Error>) -> ())
}
