//
//  Coordinator.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import UIKit

// MARK: Coordinator Protocol
protocol Coordinator {
    
    var navigator: UINavigationController { get }
    
    func start()
    func finish()
}

// MARK: Coordinator Extensions
// Creamos la extension del protocolo, para no tener que declararlo en todas las clases donde lo implementemos.
extension Coordinator {
    
    func finish() {
        navigator.dismiss(animated: true, completion: nil) //-> Navega hacia atras de la pantalla que esta presente
    }
}
