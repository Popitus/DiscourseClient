//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 23/7/21.
//

import UIKit

// MARK: UserDetailViewController class
class UserDetailViewController: UIViewController {
        
    // Properties
    
    lazy var labelUserIdValue: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var userIdStackView: UIStackView = {
        let labelUserId: UILabel = UILabel()
        labelUserId.translatesAutoresizingMaskIntoConstraints = false
        labelUserId.text = "User ID: "

        let stack: UIStackView = UIStackView(arrangedSubviews: [labelUserId, labelUserIdValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()

    lazy var labelNameValue: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var nameStackView: UIStackView = {
        let labelName: UILabel = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = "User Name: "

        let stack: UIStackView = UIStackView(arrangedSubviews: [labelName,labelNameValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()

    lazy var updateNameButton: UIButton =  {
        let button: UIButton = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Update name", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(updateNameButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var textFieldUserName: UITextField = {
        let textFieldUserName: UITextField = UITextField()
         textFieldUserName.borderStyle = .line
         textFieldUserName.translatesAutoresizingMaskIntoConstraints = false
         return textFieldUserName
    }()

    lazy var newUserNameIDStackView: UIStackView = {
        let labelNewName: UILabel = UILabel()
        labelNewName.translatesAutoresizingMaskIntoConstraints = false
        labelNewName.text = "New User Name: "

        let stack: UIStackView = UIStackView(arrangedSubviews: [labelNewName, textFieldUserName])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    let viewModel: UserDetailViewModel	    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // lifecicle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(userIdStackView)
        NSLayoutConstraint.activate([
            userIdStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIdStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])

        view.addSubview(nameStackView)
        NSLayoutConstraint.activate([
            nameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameStackView.topAnchor.constraint(equalTo: userIdStackView.bottomAnchor, constant: 32)
        ])

        view.addSubview(newUserNameIDStackView)
        NSLayoutConstraint.activate([
            newUserNameIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            newUserNameIDStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 32),
            textFieldUserName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])

        view.addSubview(updateNameButton)
        NSLayoutConstraint.activate([
            updateNameButton.topAnchor.constraint(equalTo: newUserNameIDStackView.bottomAnchor, constant: 32),
            updateNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateNameButton.heightAnchor.constraint(equalToConstant: 40),
            updateNameButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Llamada al viewModel que hará la lógica pertinente
        viewModel.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoader()
        viewModel.viewDidLoad() // Si estamos en el detalle de un User	, nos movemos a otra tab del tabBar y volvemos al detalle del User.
        
    }
    
    // Functions
    @objc func updateNameButtonTapped() {
        guard let name: String = textFieldUserName.text, !name.isEmpty else {
            showAlert(title: "Error in textfield", message: "")
            return
        }
        viewModel.updateNameButton(updateName: name)
        showLoader()
        
    }
    
    private func updateData(userDetail: UserDetailViewModelStruct) {
        labelUserIdValue.text = userDetail.userId
        labelNameValue.text = userDetail.nameLabel
        updateNameButton.isHidden = !userDetail.canEditName
        newUserNameIDStackView.isHidden = !userDetail.canEditName
        hideLoader()
    }
    
    private func showErrorFetchingUser() {
        showAlert(title: "Error fetching user", message: "")
        hideLoader()
    }
    
    private func showSuccessUpdatingUserName() {
        hideLoader()
        showAlert(title: "The user name has been succesfully updated!!", message: "")
    }
    
    private func showErrorUpdatingUserName() {
        hideLoader()
        showAlert(title: "Error updating user name", message: "")
    }
    
    
}

// MARK: UserDetailViewController extensions
// la extension del protocolo del viewmodel, para poder pintar la lógica de ViewModel en el ViewController
extension UserDetailViewController: UserDetailViewModelProtocol {
    
    // UpdateName functions
    func onUpdateUserNameSuccess() {
        showSuccessUpdatingUserName()
    }
    
    func onUpdateUserNameFail() {
        showErrorUpdatingUserName()
    }
       
    // Users functions
    func onGetUserSucces(userDetail: UserDetailViewModelStruct) {
        updateData(userDetail: userDetail)
    }
    
    func onGetUserFail() {
        showErrorFetchingUser()
    }
    
    
}
