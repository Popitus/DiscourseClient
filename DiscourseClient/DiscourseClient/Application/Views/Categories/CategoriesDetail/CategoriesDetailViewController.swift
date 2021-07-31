//
//  CategoriesDetailViewController.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

class CategoriesDetailViewController: UIViewController {

    let viewModel: CategoriesDetailViewModel
    
    var labelCategorieID: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categorieIDStackView: UIStackView = {
        let labelCategorieIDTitle: UILabel = UILabel()
        labelCategorieIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelCategorieIDTitle.text = "Topic ID: "
        
        let categorieIDStackView: UIStackView = UIStackView(arrangedSubviews: [labelCategorieIDTitle, labelCategorieID])
        categorieIDStackView.translatesAutoresizingMaskIntoConstraints = false
        categorieIDStackView.axis = .horizontal
        return categorieIDStackView
    }()
    
    let labelCategorieName: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categorieNameStackView: UIStackView = {
        let categorieNameLabel: UILabel = UILabel()
        categorieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        categorieNameLabel.text = "Number of posts: "
        
        let categorieNameStackView: UIStackView = UIStackView(arrangedSubviews: [categorieNameLabel, labelCategorieName])
        categorieNameStackView.translatesAutoresizingMaskIntoConstraints = false
        categorieNameStackView.axis = .horizontal
        return categorieNameStackView
    }()
    
    lazy var viewColor: UIView = {
        let viewColorButton: UIView = UIView()
        viewColorButton.translatesAutoresizingMaskIntoConstraints = false
        viewColorButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        viewColorButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        viewColorButton.layer.borderWidth = 2
        viewColorButton.layer.borderColor = UIColor.black.cgColor
        viewColorButton.layer.cornerRadius = 10
        return viewColorButton

    }()
  
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(categorieIDStackView)
        NSLayoutConstraint.activate([
            categorieIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categorieIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        
        view.addSubview(categorieNameStackView)
        NSLayoutConstraint.activate([
            categorieNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categorieNameStackView.topAnchor.constraint(equalTo: categorieIDStackView.bottomAnchor, constant: 16),
            categorieNameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        view.addSubview(viewColor)
        NSLayoutConstraint.activate([
            viewColor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewColor.topAnchor.constraint(equalTo: categorieNameStackView.bottomAnchor, constant: 32)
        ])
        
    }
    
    
    init(viewModel: CategoriesDetailViewModel) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        showLoader()
        viewModel.viewDidLoad() // Si estamos en un topic, nos movemos a otra tab del tabBar y volvemos al detalle del topic.

    }
    
    private func updateUI(categoriesDetailViewModelStruct: CategoriesDetailViewModelStruct) {
        labelCategorieID.text = categoriesDetailViewModelStruct.categoryId
        labelCategorieName.text = categoriesDetailViewModelStruct.categoryName
        viewColor.backgroundColor = categoriesDetailViewModelStruct.categoryColor
    }
    
    
    func bindViewModel() {
        
        viewModel.onGetCategorySuccess = { [weak self] categoriesDetailViewModelStruct in
            self?.hideLoader()
            self?.updateUI(categoriesDetailViewModelStruct: categoriesDetailViewModelStruct)
            
            
        }
        
    }
    
 



}
