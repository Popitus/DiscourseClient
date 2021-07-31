//
//  TopicDetailUsesCases.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import Foundation

protocol TopicDetailUseCases {
    func fetchDetailTopic(id: Int, completion: @escaping(Result<TopicDetailResponse?, Error>) -> Void)
    func deleteTopic(id: Int, completion: @escaping(Result<DeleteTopicResponse?, Error>) -> Void)
}
