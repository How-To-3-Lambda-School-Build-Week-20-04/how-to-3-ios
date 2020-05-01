//
//  GuidesDetailViewController.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/30/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class GuidesDetailViewController: UIViewController {
    
    var backendController = BackendController.shared
    var post: Post?
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var guidesTitleLabel: UILabel!
    @IBOutlet private weak var postBodyTextView: UITextView!
    @IBOutlet private weak var guideLikes: UILabel!
    @IBOutlet private weak var timeStampLabel: UILabel!
    @IBOutlet private weak var guideTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateViews()
        guideTextField.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    private func updateViews() {
        guard let post = post else { return }
        userNameLabel.text = String("User ID: \(post.userID)")
        guidesTitleLabel.text = post.title
        postBodyTextView.text = post.post
        guideLikes.text = String(post.likes)
        timeStampLabel.text = post.timestamp
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
