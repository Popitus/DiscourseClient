//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import UIKit

class TopicsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    let viewModel: TopicsViewModel
    
    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoader()
        viewModel.viewDidLoad()
        print("viewDidLoad->TopicsViewController")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDIsappear -> TopicsViewController")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidappear -> TopicsViewController")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear -> TopicsViewController")

    }
    override func viewWillLayoutSubviews() {
        print("viewWillLayOutSubView -> TopicsViewController")
    }
    override func viewDidLayoutSubviews() {
        print("viewDidLayOutSubView -> TopicsViewController")

    }
    
    private func onTopicsFetched() {
        hideLoader()
        tableView.reloadData()
    }
    
    private func onTopicsFetchError() {
        hideLoader()
        showAlert(title: "Error fetching topics", message: "")
    }
    
    @objc private func onTapAddButton() {
        viewModel.onTapAddButton()
    }
    
    
}

// MARK: TopicsViewController extensions -> UITableViewDelegate
extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRowat(at: indexPath)
    }
}

// MARK: TopicsViewController extensions -> UITableViewDataSource
extension TopicsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TopicCell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
           let cellViewModel: TopicCellViewModel = viewModel.cellViewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
    
    
}

extension TopicsViewController {
    
}

// MARK: TopicsViewController extensions -> TopicsViewProtocol
extension TopicsViewController: TopicsViewModelProtocol {
    func topicsFetched() {
        onTopicsFetched()
    }
    
    func errorFetchingTopics() {
        onTopicsFetchError()
    }
}

