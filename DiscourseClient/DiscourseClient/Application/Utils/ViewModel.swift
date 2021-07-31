//
//  ViewModel.swift
//  DiscourseClient
//
//  Created by Oliver Ramírez Cáceres on 22/7/21.
//

import Foundation

// MARK: ViewModel Protocol
// Este ViewModel será el padre de los siguientes ViewModels que creemos.
protocol ViewModel {
    associatedtype View //la vista será un protocolo
    associatedtype Coordinator //será el propio coordinator
    associatedtype UseCases
    
    var view: View? { get } //weak
    var coordinator: Coordinator? { get }
    var useCases: UseCases { get }
    
}
