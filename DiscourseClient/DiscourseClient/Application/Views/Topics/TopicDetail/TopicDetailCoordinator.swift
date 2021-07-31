//
//  TopicDetailCoordinator.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import UIKit

class TopicDetailCoordinator: Coordinator {
    
    var navigator: UINavigationController
    let topicId: Int
    let useCases: TopicDetailUseCases

    
    init(navigator: UINavigationController, topicId: Int, useCases: TopicDetailUseCases) {
        self.navigator = navigator
        self.topicId = topicId
        self.useCases = useCases
    }
    
    func start() {
        let topicDetailViewModel: TopicDetailViewModel = TopicDetailViewModel(topicId: topicId, useCases: useCases)
        let topicDetailViewController: TopicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
//        topicDetailViewModel.view = topicDetailViewController // como lo vamos a hacer con closure, no haria falta la inyección de dependencias
        topicDetailViewModel.coordinator = self
        topicDetailViewController.title = "Topic Detail"

        navigator.pushViewController(topicDetailViewController, animated: false)
    }
    
    func onDeleteTopicSuccess() {
        navigator.popViewController(animated: false)
    }
    
}
