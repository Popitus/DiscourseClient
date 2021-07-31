//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import UIKit

// MARK: UsersCoordinator Class
class UsersCoordinator: Coordinator {
    
    var navigator: UINavigationController
    
    let userUseCases: UsersUseCases
    let datamanager: DataManager = DataManager(remoteDataManager: RemoteDataManager())
    
    init(navigator: UINavigationController, userUseCases: UsersUseCases) {
        self.navigator = navigator
        self.userUseCases = userUseCases
    }
    
    // Llamada desde el AppCoordinator
    func start() {
        // Inyeccion de dependencias.
        // Creamos nuestro ViewModel y el ViewController con su ViewModel
        let userViewModel: UsersViewModel = UsersViewModel(useCases: userUseCases)
        let userViewController: UsersViewController = UsersViewController(viewModel: userViewModel)
        userViewController.title = "Users"
        userViewModel.view = userViewController // A traves de un protocolo
        userViewModel.coordinator = self
        navigator.pushViewController(userViewController, animated: false)
    }
    
    // Llamada desde el UserViewModel, para navegar a la nueva pantalla de detalle de usuario pulsado.
    // le pasamos la navegacion, el nombre que hemos pulsado y los casos de uso en particular.
    func didSelect(userName: String) {
        let userDetailCoordinator: UserDetailViewCoordinator = UserDetailViewCoordinator(navigator: navigator, userName: userName, useCases: datamanager)
        userDetailCoordinator.start()
    }
    
}
