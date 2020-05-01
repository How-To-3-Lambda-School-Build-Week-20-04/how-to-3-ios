//
//  UserGuidesTableViewCell.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/30/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class UserGuidesTableViewCell: UITableViewCell {
    
    var backendController = BackendController.shared
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet private weak var guidesTitleLabel: UILabel!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var timeStamp: UILabel!
    @IBOutlet private weak var loadingUsername: UILabel!
    
 private func updateViews() {
     guard let post = post else { return }
     guidesTitleLabel.text = post.title
    loadingUsername.text = String(post.userID)
     timeStamp.text = post.timestamp
     likesLabel.text = String(post.likes)

 }


}
