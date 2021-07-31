//
//  CategoriesUseCases.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import Foundation

protocol CategoriesUseCases {
    func fethAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> Void)
}
