//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import UIKit

// MARK: UserCellViewModel protocol
protocol UserCellViewModelProtocol: AnyObject {
    func userImageFetched()
}


// MARK: UserCellViewModel class
// El UserCellViewModel su vista es un protocolo

class UserCellViewModel {
    
    // Properties
    weak var view: UserCellViewModelProtocol? // -> Para la comunicación entre el cellViewModel y la propia celda y no tener una propia instancia de la UITableViewCell
    let user: User
    let textLabel: String?
    var userImage: UIImage?
    
    init(user: User) {
        self.user = user
        textLabel = user.name ?? "Sin nombre"
        
        var imageStringURL: String = "https://mdiscourse.keepcoding.io"
        imageStringURL.append(user.avatarTemplate.replacingOccurrences(of: "{size}", with: "100"))
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url: URL = URL(string: imageStringURL), let data: Data = try? Data(contentsOf: url) {
                self?.userImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.view?.userImageFetched()
                }
            }
        }
    }
}
