//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import Foundation

// MARK: TopicsViewModelProtocol protocol
protocol TopicsViewModelProtocol: AnyObject {
    func topicsFetched()
    func errorFetchingTopics()
}

// MARK: TopicsViewModel class
class TopicsViewModel: ViewModel {
    
    // Properties
    typealias View = TopicsViewModelProtocol
    typealias Coordinator = TopicsCoordinator
    typealias UseCases = TopicsUsesCases
    
    weak var view: View?
    var coordinator: Coordinator?
    var useCases: UseCases
    
    var topicCellViewModels: [TopicCellViewModel] = []
    
    init(useCases: TopicsUsesCases) {
        self.useCases = useCases
    }

    // Functions
    func viewDidLoad() {
        useCases.fetchAllTopics { [weak self] result in
            switch result {
                case .failure:
                    self?.view?.errorFetchingTopics()
                case .success(let response):
                    guard let topics: [Topic] = response?.topicList.topics else { return }
                    self?.topicCellViewModels = topics.map{ TopicCellViewModel(topic: $0) }
                    self?.view?.topicsFetched()
            }
        }
    }
    func numberOfRows(in: Int) -> Int {
        return topicCellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicCellViewModels.count else { return nil }
        return topicCellViewModels[indexPath.row]
    }
    
    func didSelectRowat(at indexPath: IndexPath) {
        coordinator?.didSelectTopic(topic: topicCellViewModels[indexPath.row].topic)
    }
    
    func onTapAddButton() {
        coordinator?.onTapAddButton()
    }
    
}
