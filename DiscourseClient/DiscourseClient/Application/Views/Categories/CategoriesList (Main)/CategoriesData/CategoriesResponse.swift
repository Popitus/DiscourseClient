//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//


import Foundation

// MARK: CategorieResponse
struct CategoriesResponse: Codable {
    let categoryList: CategoryList

    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

// MARK: CategoryList
struct CategoryList: Codable {

    let categories: [Category]
    enum CodingKeys: String, CodingKey {
        case categories
    }
}

// MARK: Category
struct Category: Codable {
    
    let id: Int
    let name: String
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
    }
}




