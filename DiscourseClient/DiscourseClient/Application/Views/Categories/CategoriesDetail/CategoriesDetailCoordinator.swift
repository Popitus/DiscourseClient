//
//  CategorieDetailCoordinator.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

class CategoriesDetailCoordinator: Coordinator {
    
    var navigator: UINavigationController
    let categoryId: Int
    let categoriesDetailUseCases: CategoriesDetailUseCases

    
    init(navigator: UINavigationController, categoriesDetailUseCases: CategoriesDetailUseCases, categoryId: Int) {
        self.navigator = navigator
        self.categoriesDetailUseCases = categoriesDetailUseCases
        self.categoryId = categoryId
    }
    
    func start() {
        let categoriesDetailViewModel: CategoriesDetailViewModel = CategoriesDetailViewModel(categoryId: categoryId, useCases: categoriesDetailUseCases)
        let categoriesDetailViewController: CategoriesDetailViewController = CategoriesDetailViewController(viewModel: categoriesDetailViewModel)
        categoriesDetailViewModel.coordinator = self
        categoriesDetailViewController.title = "Categories Detail"
        navigator.pushViewController(categoriesDetailViewController, animated: false)
        
        
    }
    
    
}
