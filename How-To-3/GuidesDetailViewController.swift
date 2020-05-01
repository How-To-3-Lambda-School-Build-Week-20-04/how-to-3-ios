//
//  GuidesDetailViewController.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/30/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class GuidesDetailViewController: UIViewController {
    
    
    var userGuidTableController: UserGuidesTableViewController?
    var backendController = BackendController.shared
    var post: Post?
    var wasEdited = false
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var guidesTitleLabel: UILabel!
    @IBOutlet private weak var postBodyTextView: UITextView!
    @IBOutlet private weak var guideLikes: UILabel!
    @IBOutlet private weak var timeStampLabel: UILabel!
    @IBOutlet private weak var guideTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        guard let userTitle = guideTextField.text,
            !userTitle.isEmpty,
            let postBody = postBodyTextView.text,
        let post = post else { return }
        
        backendController.updatePost(at: post, title: userTitle, post: postBody) { error in
            if let error = error {
                    NSLog("Error updating: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func updateViews() {
        guard let post = post else { return }
        userNameLabel.text = String("User ID: \(post.userID)")
        guidesTitleLabel.text = post.title
        guideTextField.text = post.title
        guideTextField.isUserInteractionEnabled = isEditing
        postBodyTextView.text = post.post
        guideTextField.isUserInteractionEnabled = isEditing
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
