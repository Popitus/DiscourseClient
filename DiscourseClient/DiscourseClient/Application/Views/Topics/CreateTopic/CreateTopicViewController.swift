//
//  CreateTopicViewController.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import UIKit

class CreateTopicViewController: UIViewController {


    // Properties
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.placeholder = "Insert topic title and tap Submit"
        }
    }
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.setTitle("Submit", for: .normal)
            submitButton.backgroundColor = .gray
            submitButton.setTitleColor(.black, for: .normal)
            submitButton.layer.cornerRadius = 10
        }
    }
    
    let viewModel: CreateTopicViewModel
    
    init(viewModel: CreateTopicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoadCreateTopic -> CreateTopicViewController")

        bindViewModel()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        viewModel.onCreateTopicSuccess = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Topic created", message: "")
        }
        
        viewModel.onCreateTopicFail = { [weak self] error in
            self?.hideLoader()
            self?.showAlert(title: error, message: "")
        }
    }
    
    @IBAction func onTapSubmitButton(_ sender: Any) {
        guard let text: String = textField.text, !text.isEmpty else {
            showAlert(title: "Textfield empty", message: "")
            return
        }
        showLoader()
        viewModel.onTapSubmitButton(title: text)
    }
    
    
}
extension CreateTopicViewController: CreateTopicViewProtocol {}
