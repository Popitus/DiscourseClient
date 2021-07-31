//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation

// MARK: UserViewModelProtocol protocol
protocol UserViewModelProtocol:AnyObject {
    func userFetched()
    func errorFetchingUsers()
}

// MARK: UserViewModel class
class UsersViewModel: ViewModel {
    
    // Properties
    
    typealias View = UserViewModelProtocol // recordar que nuestra vista View es un protocolo
    typealias Coordinator = UsersCoordinator // el encargado de la navegación
    typealias UseCases = UsersUseCases // nuestro caso de uso
    
    weak var view: View? // Recordar añadir el weak. 
    var coordinator: Coordinator?
    var useCases: UseCases
    
    var userCellViewModel: [UserCellViewModel] = []
    
    init(useCases: UsersUseCases) {
        self.useCases = useCases
    }
    
    // Functions
    func viewDidLoad() {
        useCases.fetchAllUsers { [weak self] result in
            switch result {
            case .failure:
                // En caso de error, llamamos al nuestro ViewController mediante el protocolo para no tener referencias cíclicas
                self?.view?.errorFetchingUsers()
            case .success(let response):
                guard let response: UsersResponse = response else {
                    self?.view?.errorFetchingUsers()
                    return
                }
                // En caso de éxito, rellenamos el cellViewModel con los datos recibidos de user
                self?.userCellViewModel = response.directoryItems.map{UserCellViewModel(user: $0.user)}
                self?.view?.userFetched()
                
            }
        }
    }

    // Numero de filas
    func numberOfRows(in Section: Int) -> Int {
        return userCellViewModel.count
    }
    
    // Celda de la fila
    func cellViewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userCellViewModel.count else { return nil }
        return userCellViewModel[indexPath.row]
    }
    
    // Numero de secciones
    func numberOfSections() -> Int {
        return 1
    }
    
    // El viewModel le pasará al coordinator para la navegacion a la vista detalle
    // Le pasamos el nombre que estará en userCellViewModel, que contiene dentro user
    func didSelectRow(at indexPath: IndexPath) {
        coordinator?.didSelect(userName: userCellViewModel[indexPath.row].user.username)
        
    }

    
}


