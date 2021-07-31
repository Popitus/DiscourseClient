//
//  CategoriesDetailUseCases.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import Foundation

protocol CategoriesDetailUseCases {
    func fetchDetailCategories(id: Int, completion: @escaping(Result<CategoriesDetailResponse?, Error>) -> Void)
}
