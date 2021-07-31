//
//  CreateCategoriesCoordinator.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 28/7/21.
//

import UIKit

class CreateCategoriesCoordinator: Coordinator {
    
    var navigator: UINavigationController
    let createCategorieUseCases: CreateCategorieUseCases
    
    init(navigator: UINavigationController, createCategorieUseCases: CreateCategorieUseCases) {
        self.navigator = navigator
        self.createCategorieUseCases = createCategorieUseCases
    }
    
    func start() {
        let createCategorieViewModel: CreateCategoriesViewModel = CreateCategoriesViewModel(useCases: createCategorieUseCases)
        let createCategorieViewController: CreateCategoriesViewController = CreateCategoriesViewController(viewModel: createCategorieViewModel)
        
        createCategorieViewModel.view = createCategorieViewController
        createCategorieViewModel.coordinator = self
        createCategorieViewController.title = "Create Category"
        
        //para presentar la pantalla de manera modal
        let navigationController = UINavigationController(rootViewController: createCategorieViewController)
        navigator.present(navigationController, animated: true, completion: nil)
        
    }
    
    
}
