//
//  APPCoordinator.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 21/7/21.
//

import UIKit


// MARK: Class AppCoordinator
class AppCoordinator {
    
    // Properties
    var navigator: UINavigationController = UINavigationController()
    let window: UIWindow

    var dataManager = DataManager(remoteDataManager: RemoteDataManager())

    init(window: UIWindow) {
        self.window = window
    }
    
    // Functions
    
    // Función start para crear el TabBar
    func start() {
        
        // Creamos el TabBar
        let tabBarController: UITabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        
        // *** Inicializar viewController dentro del TabBar ***
        
        // El coordinator será el encargado de realizar la navegación
        let userNavigator: UINavigationController = UINavigationController()
        let userCoordinator: UsersCoordinator = UsersCoordinator(navigator: userNavigator, userUseCases: dataManager)
        userCoordinator.start()
        
        let topicsNavigator: UINavigationController = UINavigationController()
        let topicsCoordinator: TopicsCoordinator = TopicsCoordinator(navigator: topicsNavigator, topicsUseCase: dataManager)
        topicsCoordinator.start()
        
        let categoriesNavigator: UINavigationController = UINavigationController()
        let categoriesCoordinator: CategoriesCoordinator = CategoriesCoordinator(navigator: categoriesNavigator, categoriesUseCases: dataManager)
        categoriesCoordinator.start()
        
        // ViewControllers del TabBar
        tabBarController.viewControllers = [userNavigator, topicsNavigator,categoriesNavigator]
        tabBarController.tabBar.items?.first?.image = UIImage(systemName: "tag")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "list.dash")
        tabBarController.tabBar.items?[2].image = UIImage(systemName: "tray.fill")
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
    }
}


