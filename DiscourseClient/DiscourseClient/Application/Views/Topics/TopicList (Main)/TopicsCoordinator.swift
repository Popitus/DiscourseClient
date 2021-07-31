//
//  TopicsCoordinator.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import UIKit

// MARK: TopicsCoordinator class
class TopicsCoordinator: Coordinator {
    
    // Properties
    var navigator: UINavigationController
    
    let dataManager: DataManager = DataManager(remoteDataManager: RemoteDataManager())
    let topicsUseCases: TopicsUsesCases
    
    init(navigator: UINavigationController, topicsUseCase: TopicsUsesCases) {
        self.navigator = navigator
        self.topicsUseCases = topicsUseCase
    }
    
    // Functions
    func start() {
        let topicsViewModel = TopicsViewModel(useCases: topicsUseCases)
        let topicsViewController = TopicsViewController(viewModel: topicsViewModel)
        topicsViewController.title = "Topics"
        topicsViewModel.view = topicsViewController
        topicsViewModel.coordinator = self
        navigator.pushViewController(topicsViewController, animated: false)
    }
    
    func didSelectTopic(topic: Topic) {
        let topicDetailCoordinator: TopicDetailCoordinator = TopicDetailCoordinator(navigator: navigator, topicId: topic.id, useCases: dataManager)
        topicDetailCoordinator.start()
    }

    func onTapAddButton() {
        let createTopicCoordinator: CreateTopicCoordinator = CreateTopicCoordinator(navigator: navigator, createTopicUseCases: dataManager)
        createTopicCoordinator.start()
    }
}
