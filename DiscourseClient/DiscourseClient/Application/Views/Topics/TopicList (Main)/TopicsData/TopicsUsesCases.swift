//
//  TopicsUsesCases.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import Foundation

protocol TopicsUsesCases {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> Void)
}
