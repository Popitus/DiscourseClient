//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

// MARK: CategoriesViewController class
class CategoriesViewController: UIViewController {

    // Properties
    let viewModel: CategoriesViewModel
    
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CategoriesCellViewController", bundle: nil), forCellReuseIdentifier: "CategoriesCellViewController") // niBname de xib que vamos a usar.
        table.estimatedRowHeight = 100 // -> el tamaño que va a tratar de dar a todas las celdas
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // Creamos la vista y añadimos la tabla
        view = UIView() // view es una variable que hereda de la clase UIViewController
        view.backgroundColor = .white
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(onTapAddButton))
        rightBarButtonItem.tintColor = .black
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        // la vista (UsersViewController) va a reaccionar con el model (UsersViewModel)
        viewModel.viewDidLoad() // función que llama al UsersViewModel
        showLoader()
 
    }
    
    func showErrorFetchingCategories() {
        showAlert(title: "Error Fetching Categories!", message: "")
    }
    
    @objc private func onTapAddButton() {
        viewModel.onTapAddButton()
    }
    

}

// MARK: CategoriesViewController Extensions
extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = UIColor(hexString: viewModel.backgroundCellColor(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowat(at: indexPath)
        
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: CategoriesCellViewController = tableView.dequeueReusableCell(withIdentifier: "CategoriesCellViewController", for: indexPath) as? CategoriesCellViewController {
            let cellViewModel = viewModel.cellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
    
}

extension CategoriesViewController: CategoriesViewModelProtocol {
    
    func categoriesFetched() {
        hideLoader()
        tableView.reloadData()
    }
    
    func errorFetchingCategories() {
        hideLoader()
        showErrorFetchingCategories()
    }
    
    
    
}
