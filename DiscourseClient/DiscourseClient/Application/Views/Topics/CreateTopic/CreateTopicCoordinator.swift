//
//  CreateTopicCoordinator.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

class CreateTopicCoordinator: Coordinator {
    
    var navigator: UINavigationController
    let createTopicUseCases : CreateTopicUseCases

    
    init(navigator: UINavigationController, createTopicUseCases: CreateTopicUseCases) {
        self.navigator = navigator
        self.createTopicUseCases = createTopicUseCases
    }
    
    func start() {
        let createTopicViewModel = CreateTopicViewModel(useCases: createTopicUseCases)
        let createTopicViewController = CreateTopicViewController(viewModel: createTopicViewModel)
        
        createTopicViewModel.view = createTopicViewController // -> Como lo vamos a hacer con closure. no haria falta la inyección de dependencias
        createTopicViewModel.coordinator = self
        createTopicViewController.title = "Add title"
        
        // Presetamos la pantalla de manera Modal.
        let navigationController = UINavigationController(rootViewController: createTopicViewController)
        navigator.present(navigationController, animated: true, completion: nil)
    }
    
    
}
