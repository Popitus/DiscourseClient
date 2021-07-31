//
//  UserDetailCoordinator.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 23/7/21.
//

import UIKit

// MARK: UserDetailViewCoordinator class
class UserDetailViewCoordinator: Coordinator {
    
    // Properties
    var navigator: UINavigationController
    let userName: String
    let useCases: UserDetailUseCases
    
    init(navigator: UINavigationController, userName: String, useCases: UserDetailUseCases) {
        self.navigator = navigator
        self.userName = userName
        self.useCases = useCases
    }
    
    // Functions
    func start() {
        // llamada desde el UsersCoordinator. Creamos el ViewModel y ViewController propio del detalle.
        let userDetailViewModel: UserDetailViewModel = UserDetailViewModel(userName: userName, useCases: useCases)
        let userDetailViewController: UserDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        userDetailViewModel.view = userDetailViewController
        userDetailViewModel.coordinator = self
        userDetailViewController.title = userName
        navigator.pushViewController(userDetailViewController, animated: false)
        
    }
    
}
