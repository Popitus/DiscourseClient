//
//  UserCellViewController.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import UIKit

class UserCellViewController: UITableViewCell {

    // Properties
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel: UserCellViewModel = viewModel else { return }
            viewModel.view = self // La vista no es el UserCellViewController.. Es el protocolo Linea 22 del UserCellViewModel
            textLabel?.text = viewModel.textLabel // El primer textLabel es el propio de la UITableViewCell
            imageView?.image = viewModel.userImage // El imageView es el propio de la UITableViewCell
        }
    }
}

extension UserCellViewController: UserCellViewModelProtocol {
    
    func userImageFetched() {
        imageView?.image = viewModel?.userImage
        setNeedsLayout()
    }
}
