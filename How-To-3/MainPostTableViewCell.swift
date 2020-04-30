//
//  MainPostTableViewCell.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/28/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit
import CoreData
class MainPostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    var backendController = BackendController.shared
    var postRepresentation: PostRepresentation?

   
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var timeStampLabel: UILabel!
    
  
    
    
    private func updateViews() {
        guard let post = post else { return }
        postTitleLabel.text = post.title
        authorNameLabel.text = String(post.userID)
        timeStampLabel.text = post.timestamp
        likesLabel.text = String(post.likes)

    }

}
