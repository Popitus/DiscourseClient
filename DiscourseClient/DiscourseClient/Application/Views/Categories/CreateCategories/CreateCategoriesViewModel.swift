//
//  CreateCategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 28/7/21.
//

import Foundation

protocol CreateCategoriesViewModelProtocol {}

class CreateCategoriesViewModel: ViewModel {
    
    typealias View = CreateCategoriesViewModelProtocol
    typealias Coordinator = CreateCategoriesCoordinator
    typealias UseCases = CreateCategorieUseCases
    
    var view: View?
    var coordinator: Coordinator?
    var useCases: UseCases
    
    var onCreateCategorieSuccess: (() -> ())?
    var onCreateCategorieFail: ((String) -> ())?
    
    init(useCases: UseCases) {
        self.useCases = useCases
    }
    
    func onTapSubmitButton(category: String) {
        let categoryTextColor: String = "f0fcfd"
        let colorCategory: String = "49d9e9"
        
        useCases.createCategorie(name: category, color: colorCategory, textColor: categoryTextColor) { [weak self] result in
            switch result {
            
            case .failure(let error):
                guard let responseError: SessionAPIError = error as? DiscourseClient.SessionAPIError else {
                    self?.onCreateCategorieFail?("Error Response")
                    return
                }
                var message = error.localizedDescription
                
                switch responseError {
                case .apiError(let msg): message = msg.errors?.first ?? error.localizedDescription
                case .httpError(let code): message = "Error Code: \(code)"
                }
                
                self?.onCreateCategorieFail?(message)
            case .success:
                self?.onCreateCategorieSuccess?()
            }
            
        }
    }
    
    
}
