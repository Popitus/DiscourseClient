//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 23/7/21.
//

import Foundation

// MARK: UserDetailViewModelProtocol protocol
// Declaración de protocolos que luego será extendido en el ViewController
protocol UserDetailViewModelProtocol: AnyObject {
    
    // Users functions
    func onGetUserSucces(userDetail: UserDetailViewModelStruct)
    func onGetUserFail()
    
    // UpdateUser functions
    func onUpdateUserNameSuccess()
    func onUpdateUserNameFail()
    
}

// Struct para mandarselo a la vista directamente, mandadole un objeto directo.
struct UserDetailViewModelStruct {
    var userId: String?
    var nameLabel: String?
    var canEditName: Bool = true
}

// MARK: UserDetailViewModel class
class UserDetailViewModel: ViewModel {
    
    // properties
    typealias View = UserDetailViewController
    typealias Coordinator = UserDetailViewCoordinator
    typealias UseCases = UserDetailUseCases
    
    weak var view: View?
    var coordinator: Coordinator?
    var useCases: UseCases
    
    // Al UsersCoordinator, le pasamos un username. Para el caso de este uso, hará falta.
    let userName: String
    
    init(userName: String, useCases: UserDetailUseCases) {
        self.useCases = useCases
        self.userName = userName
    }
    
    
    // functions
    func viewDidLoad() {
        useCases.fetchUser(username: userName) { [weak self] result in
            switch result {
                case .failure:
                    self?.view?.onGetUserFail()
                case .success(let response):
                    guard let response: UserDetailResponse = response else {return}
                    let userDetailViewModelStruct: UserDetailViewModelStruct = UserDetailViewModelStruct(userId: "\(response.user.id)", nameLabel: response.user.name, canEditName: response.user.canEditName)
                    self?.view?.onGetUserSucces(userDetail: userDetailViewModelStruct)
                    
                    
            }
        }
    }
    func updateNameButton(updateName: String) {
        useCases.updateUserName(userName: userName, name: updateName) { [weak self] result in
            switch result {
                case .failure:
                    self?.view?.onUpdateUserNameFail()
                case .success:
                    self?.view?.onUpdateUserNameSuccess()
            }
        }
    }
}
