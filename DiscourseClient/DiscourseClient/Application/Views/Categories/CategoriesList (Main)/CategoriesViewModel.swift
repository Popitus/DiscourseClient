//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import Foundation

protocol CategoriesViewModelProtocol: AnyObject {
    func categoriesFetched()
    func errorFetchingCategories()
}

// MARK: CategoriesViewModel class
class CategoriesViewModel: ViewModel {
    
    // Properties
    typealias View = CategoriesViewModelProtocol
    typealias Coordinator = CategoriesCoordinator
    typealias UseCases = CategoriesUseCases
    
    weak var view: View?
    var coordinator: Coordinator?
    var useCases: UseCases
    
    var categoriesCellViewModel: [CategoriesCellViewModel] = []
    
    init(useCases: CategoriesUseCases) {
        self.useCases = useCases
    }
    
    // Functions
    func viewDidLoad() {
        useCases.fethAllCategories { [weak self] result in
            switch result {
                case .failure:
                    self?.view?.errorFetchingCategories()
                case .success(let response):
                    guard let response: CategoriesResponse = response else {
                        self?.view?.errorFetchingCategories()
                        return
                    }
                    self?.categoriesCellViewModel = response.categoryList.categories.map{CategoriesCellViewModel(category: $0) }
                    self?.view?.categoriesFetched()
            }
        }
    }
    
    func numberOfRows(in indexPath: Int) -> Int {
        return categoriesCellViewModel.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CategoriesCellViewModel? {
        guard indexPath.row < categoriesCellViewModel.count else { return nil }
        return categoriesCellViewModel[indexPath.row]
    }
    
    func backgroundCellColor(at indexPath: IndexPath) -> String {
        return categoriesCellViewModel[indexPath.row].category.color
    }
    
    func didSelectRowat(at indexPath: IndexPath) {
        coordinator?.didSelectTopic(categories: categoriesCellViewModel[indexPath.row].category)
    }
    
    func onTapAddButton() {
        coordinator?.onTapAddButton()
    }
    
    
}
