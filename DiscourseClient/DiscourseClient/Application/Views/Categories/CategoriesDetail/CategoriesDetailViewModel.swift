//
//  CategorieDetailViewModel.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

protocol CategoriesDetailViewModelProtocolo: AnyObject {}

struct CategoriesDetailViewModelStruct {
    let categoryId: String
    let categoryName: String
    let categoryColor: UIColor
}

class CategoriesDetailViewModel: ViewModel {
    
    typealias View = CategoriesDetailViewModelProtocolo
    typealias Coordinator = CategoriesDetailCoordinator
    typealias UseCases = CategoriesDetailUseCases
    
    weak var view: View? // Como vamos a realizar la llamada por closure, no se llamara a la vista por protocolo
    var coordinator: Coordinator?
    var useCases: UseCases
    
    let categoryId: Int
    
    // Closures
    var onGetCategorySuccess: ((CategoriesDetailViewModelStruct)->())?
    var onGetCategoryFail: (()->())?
    
    init(categoryId: Int, useCases: UseCases) {
        self.useCases = useCases
        self.categoryId = categoryId
    }
    
    func viewDidLoad() {
        useCases.fetchDetailCategories(id: categoryId) { [weak self] result in
            switch result {
            
            case .failure:
                self?.onGetCategoryFail?()
            case .success(let response):
                guard let response: CategoriesDetailResponse = response else { return }
                let categoriesDetailViewModelStruct: CategoriesDetailViewModelStruct = CategoriesDetailViewModelStruct(categoryId: "\(response.category.id)", categoryName: response.category.name, categoryColor: UIColor(hexString: response.category.color))
                self?.onGetCategorySuccess?(categoriesDetailViewModelStruct)
            }
        }
    }
    
}
