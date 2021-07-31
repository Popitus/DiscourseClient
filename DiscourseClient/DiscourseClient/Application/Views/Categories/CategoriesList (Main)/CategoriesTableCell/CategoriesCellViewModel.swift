//
//  CategoriesCellViewModel.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

protocol CategoriesCellViewModelProtocol: AnyObject {
    func categoriesFetched()
}

class CategoriesCellViewModel {
    
    weak var view: CategoriesCellViewModelProtocol?
    let category: Category
    let textLabelId: Int
    let textLabelName: String
    
    init(category: Category) {
        self.category = category
        textLabelId = category.id
        textLabelName = category.name
      
        DispatchQueue.main.async {
            self.view?.categoriesFetched()
        }
    }
}
