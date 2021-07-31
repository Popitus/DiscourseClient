//
//  ViewController.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 21/7/21.
//

import UIKit

// MARK: UsersViewController Class
class UsersViewController: UIViewController {

    // Properties
    
    let viewModel: UsersViewModel
    
    // tableView de la vista UserViewController.
    lazy var tableView: UITableView = {
        let table: UITableView = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "UserCellViewController", bundle: nil), forCellReuseIdentifier: "UserCellViewController") // niBname de xib que vamos a usar.
        table.estimatedRowHeight = 100 // -> el tamaño que va a tratar de dar a todas las celdas
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // LifeCicle
    // loadView -> para pintar la vista y definición de vista. Con un xib no haría falta
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
    }
    
    // Recordar que viewDidLoad se llama cuando se carga la vista. Informamos al viewModel (UsersViewModel)
    override func viewDidLoad() {
        super.viewDidLoad()
               
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // la vista (UsersViewController) va a reaccionar con el model (UsersViewModel)
        viewModel.viewDidLoad() // función que llama al UsersViewModel
        showLoader()

    }
    
    func showErrorFetchingUsers() {
        showAlert(title: "Error Fetching Users!", message: "")
    }



}

// MARK: UsersViewController Extensions

extension UsersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UserCellViewController = tableView.dequeueReusableCell(withIdentifier: "UserCellViewController", for: indexPath) as? UserCellViewController {
            let cellViewModel = viewModel.cellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Llama al viewModel con la celda seleccionada
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UserViewModelProtocol {
    
    func userFetched() {
        hideLoader()
        tableView.reloadData()
    }
    
    func errorFetchingUsers() {
        hideLoader()
        showErrorFetchingUsers()
    }
    
    
}

