//
//  CreateCategorieUseCases.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 28/7/21.
//

import Foundation


protocol CreateCategorieUseCases {
    func createCategorie(name:String, color: String, textColor: String, completion: @escaping (Result<CreateCategorieResponse?, Error>) -> Void)
}
