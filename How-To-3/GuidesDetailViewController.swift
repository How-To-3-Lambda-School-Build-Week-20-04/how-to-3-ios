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
        guideTextField.isHidden = true
        if wasEdited == true {
            guidesTitleLabel.isHidden = true
            guideTextField.isHidden = false
            postBodyTextView.isEditable = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if wasEdited {
            guard let title = guideTextField.text,
                !title.isEmpty,
                let notes = postBodyTextView.text,
                let post = post else {
                    return
            }
        
            post.title = title
            post.post = notes
            backendController.updatePost(at: post, title: title, post: notes) { error in
                if let error = error {
                    NSLog("error in updates")
                    return
                }
            }
            do {
                try CoreDataStack.shared.mainContext.save()
            } catch {
                NSLog("Error saving managed object context: \(error)")
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing { wasEdited = true }
        
        guard let title = guideTextField,
            let body = postBodyTextView else { return }
        title.isUserInteractionEnabled = editing
        body.isUserInteractionEnabled = editing
        navigationItem.hidesBackButton = editing
    }
    
    
    private func updateViews() {
        guard let post = post else { return }
        userNameLabel.text = String("User ID: \(post.userID)")
        guidesTitleLabel.text = post.title
        guidesTitleLabel.isUserInteractionEnabled = isEditing
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
