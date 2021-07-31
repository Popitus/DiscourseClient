//
//  CreateCategoriesViewController.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 28/7/21.
//

import UIKit

class CreateCategoriesViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var submmitButton: UIButton!
    
    let viewModel: CreateCategoriesViewModel
    
    init(viewModel: CreateCategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.onCreateCategorieSuccess = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Topic created", message: "")
        }
        
        viewModel.onCreateCategorieFail = { [weak self] error in
            self?.hideLoader()
            self?.showAlert(title: error, message: "")
        }
    }
    
    @IBAction func onTapSubmitButton(_ sender: UIButton) {
        guard let newCategory: String = textField.text, !newCategory.isEmpty else {
            showAlert(title: "Textfield empty", message: "")
            return
        }
        showLoader()
        viewModel.onTapSubmitButton(category: newCategory)
    }
    
}

extension CreateCategoriesViewController: CreateCategoriesViewModelProtocol {}

