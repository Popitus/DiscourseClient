//
//  CreateTopicViewModel.swift
//  DiscourseClient
//
//  Created by MacAMD on 25/7/21.
//

import Foundation

protocol CreateTopicViewProtocol {}

class CreateTopicViewModel: ViewModel {
    typealias View = CreateTopicViewProtocol
    typealias Coordinator = CreateTopicCoordinator
    typealias UseCases = CreateTopicUseCases
    
    var view: View?
    var coordinator: Coordinator?
    var useCases: UseCases
    
    var onCreateTopicSuccess: (() -> Void)?
    var onCreateTopicFail: ((String) -> Void)?
    var dismissView: (() -> Void)?
    

    init(useCases: CreateTopicUseCases) {
        self.useCases = useCases
    }
    
    func onTapSubmitButton(title: String) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let createdAt: String = dateFormatter.string(from: Date())
        
        useCases.createTopic(title: title, raw: title, createdAt: createdAt) { [weak self] result in
            switch result {
            case .success: self?.onCreateTopicSuccess?()
            case .failure(let error):
                guard let responseError: SessionAPIError = error as? DiscourseClient.SessionAPIError else {
                    self?.onCreateTopicFail?("")
                    return
                }
                var message: String = error.localizedDescription
                switch responseError {
                case .apiError(let msg):
                    message = msg.errors?.first ?? error.localizedDescription
                case .httpError(let code):
                    message = "Error Code: \(code)"
                }
                self?.onCreateTopicFail?(message)
            }
        }
    }
    
}
