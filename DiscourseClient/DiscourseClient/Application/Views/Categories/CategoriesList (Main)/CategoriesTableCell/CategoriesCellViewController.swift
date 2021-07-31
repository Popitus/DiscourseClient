//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

class CategoriesCellViewController: UITableViewCell {

    var viewModel: CategoriesCellViewModel? {
        didSet {
            guard let viewModel: CategoriesCellViewModel = viewModel else { return }
            viewModel.view = self
            textLabel?.text = "\(viewModel.textLabelId) :" + viewModel.textLabelName
            
        }
    }
    
}

extension CategoriesCellViewController: CategoriesCellViewModelProtocol {
    func categoriesFetched() {
        setNeedsLayout()
    }
    
     
    
}
