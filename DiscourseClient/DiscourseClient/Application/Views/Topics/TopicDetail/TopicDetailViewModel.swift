//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import UIKit

protocol TopicDetailViewModelProtocol: AnyObject {}

struct TopicDetailViewModelStruct {
    let topicId : String
    let topicName : String
    let postsNumber : String
    let topicCanBeDeleted: Bool
}

class TopicDetailViewModel: ViewModel {
    typealias View = TopicDetailViewModelProtocol
    typealias Coordinator = TopicDetailCoordinator
    typealias UseCases = TopicDetailUseCases
    
    //no lo vamos a utilizar porque usamos los closures.
    weak var view: View? // En realidad este View no lo vamos a utilizar, porque vamos a llamar a la vista mediante closure.
    var coordinator: Coordinator?
    var useCases: UseCases
    
    let topicId: Int
    
    // closures
    var onGetTopicSucces: ((TopicDetailViewModelStruct) -> ())?
    var onGetTopicFail: (() -> Void)?
    var onDeleteTopicSuccess: (() -> Void)?
    var onDeleteTopicFail: (() -> Void)?

    init(topicId: Int, useCases: TopicDetailUseCases) {
        self.topicId = topicId
        self.useCases = useCases
    }
    
    func viewDidLoad() {
        useCases.fetchDetailTopic(id: topicId) { [weak self] result in
            switch result {
                
                case .failure:
                    self?.onGetTopicFail?()
                case .success(let response):
                    guard let response: TopicDetailResponse = response else { return }
                    let topicDetailViewModelStruct: TopicDetailViewModelStruct = TopicDetailViewModelStruct(topicId: "\(response.id)", topicName: response.title, postsNumber: "\(response.postsCount)", topicCanBeDeleted: response.details.canDelete ?? false)
                    self?.onGetTopicSucces?(topicDetailViewModelStruct)
            }
        }
    }
    
    func onTapDeleteButton() {
        useCases.deleteTopic(id: topicId) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.onDeleteTopicSuccess()
                self?.onDeleteTopicSuccess?()
            case .failure:
                self?.onDeleteTopicFail?()
            }
        }
    }
}
