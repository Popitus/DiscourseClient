//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by MacAMD on 24/7/21.
//

import UIKit

// MARK: TopicCell class
class TopicCell: UITableViewCell {
    
    // Properties
    var viewModel: TopicCellViewModel? {
        didSet{
            guard let viewModel: TopicCellViewModel = viewModel else {return}
            textLabel?.text = viewModel.topic.title
        }
    }
}
