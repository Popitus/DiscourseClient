//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import UIKit

class TopicDetailViewController: UIViewController {
    
    let viewModel: TopicDetailViewModel
    
    var labelTopicID: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelTopicTitle: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle: UILabel = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = "Topic ID: "
        
        let topicIDStackView: UIStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal
        return topicIDStackView
    }()
    
    
    lazy var topicNameStackView: UIStackView = {
        let labelTitleTopic: UILabel = UILabel()
        labelTitleTopic.translatesAutoresizingMaskIntoConstraints = false
        labelTitleTopic.text = "Topic Name: "
        
        let topicNameStackView: UIStackView = UIStackView(arrangedSubviews: [labelTitleTopic, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal
        return topicNameStackView
    }()
    
    let postsNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postNumberStackView: UIStackView = {
        let postNumberTitleLabel: UILabel = UILabel()
        postNumberTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        postNumberTitleLabel.text = "Number of posts: "
        
        let postNumberStackView: UIStackView = UIStackView(arrangedSubviews: [postNumberTitleLabel, postsNumberLabel])
        postNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        postNumberStackView.axis = .horizontal
        return postNumberStackView
    }()
    
    let deleteTopicButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(onTapDeleteButton), for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        
        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 16),
            topicNameStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        view.addSubview(postNumberStackView)
        NSLayoutConstraint.activate([
            postNumberStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            postNumberStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 16)
        ])
        
        view.addSubview(deleteTopicButton)
        NSLayoutConstraint.activate([
            deleteTopicButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteTopicButton.topAnchor.constraint(equalTo: postNumberStackView.bottomAnchor, constant: 32)
        ])
        
        deleteTopicButton.isHidden = true
    }

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bindViewModel()
  
    }
    override func viewWillAppear(_ animated: Bool) {
        showLoader()
        viewModel.viewDidLoad() // Si estamos en un topic, nos movemos a otra tab del tabBar y volvemos al detalle del topic.
    }
    
    @objc private func onTapDeleteButton() {
        showLoader()
        viewModel.onTapDeleteButton()
    }
    
    func bindViewModel(){
        viewModel.onGetTopicSucces = { [weak self] topicDetailViewModelStruct in
            self?.hideLoader()
            self?.updateUI(topicDetailViewModelStruct: topicDetailViewModelStruct)
        }
        
        viewModel.onGetTopicFail = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Error fetching topic", message: "")
        }
        
        viewModel.onDeleteTopicSuccess = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Success deleting topic", message: "")
        }
        
        viewModel.onDeleteTopicFail = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Error deleting topic", message: "")
        }
    }
    
    
    private func updateUI(topicDetailViewModelStruct: TopicDetailViewModelStruct) {
        labelTopicID.text = topicDetailViewModelStruct.topicId
        labelTopicTitle.text = topicDetailViewModelStruct.topicName
        postsNumberLabel.text = topicDetailViewModelStruct.postsNumber
        deleteTopicButton.isHidden = !topicDetailViewModelStruct.topicCanBeDeleted
    }
}
