//
//  CategoriesCoordinator.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

// MARK: CategoriesCoordinator class
class CategoriesCoordinator: Coordinator {
    
    // Properties
    var navigator: UINavigationController
    let dataManager: DataManager = DataManager(remoteDataManager: RemoteDataManager())
    let categoriesUseCases: CategoriesUseCases
    

    
    init(navigator: UINavigationController, categoriesUseCases: CategoriesUseCases) {
        self.navigator = navigator
        self.categoriesUseCases = categoriesUseCases
    }
    
    // functions
    func start() {
        let categoriesViewModel: CategoriesViewModel = CategoriesViewModel(useCases: categoriesUseCases)
        let categoriesViewController: CategoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        
        categoriesViewController.title = "Categories"
        categoriesViewModel.view = categoriesViewController
        categoriesViewModel.coordinator = self
        navigator.pushViewController(categoriesViewController, animated: false)
    }
    
    func didSelectTopic(categories: Category) {
        let categorieDetailCoordinator: CategoriesDetailCoordinator = CategoriesDetailCoordinator(navigator: navigator, categoriesDetailUseCases: dataManager, categoryId: categories.id)
        categorieDetailCoordinator.start()
    }
    
    func onTapAddButton() {
        let createCategoriesCoordinator: CreateCategoriesCoordinator = CreateCategoriesCoordinator(navigator: navigator, createCategorieUseCases: dataManager)
        createCategoriesCoordinator.start()
        
    }
}
