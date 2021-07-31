//
//  SceneDelegate.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 21/7/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // Una variable lazy es aquella cuyo valor asociado no se almacena hasta que la variable es llamada por primera vez.
    // Es decir, si nunca se solicita el appCoordinator, no se va a asignar en memoria
    lazy var appCoordinator: AppCoordinator = {
        guard let window: UIWindow = self.window else { fatalError() }
        let coordinator: AppCoordinator = AppCoordinator(window: window)
        return coordinator
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else { return  }
        let sceneWindow: UIWindow = UIWindow(windowScene: windowScene)
        window = sceneWindow
        appCoordinator.start()
        
    }
    
}

