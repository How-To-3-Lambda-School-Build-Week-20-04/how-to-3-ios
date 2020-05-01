//
//  CreateGuideViewController.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/30/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class CreateGuideViewController: UIViewController {

// MARK: - Properties
    
    var backendController = BackendController.shared
    
// MARK: - IBOutlets
    
    @IBOutlet private weak var createPostButton: UIButton!
    @IBOutlet private weak var guideTitleTextField: UITextField!
    @IBOutlet private  weak var guideDescription: UITextView!
    
// MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.hideKeyboardWhenTappedAround()

    self.guideDescription.layer.borderWidth = 1.0
    }
        
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "cancelSegue", sender: self)
    }
    
    @IBAction func createPostTapped(_ sender: UIButton) {
        guard let title = guideTitleTextField.text,
                 !title.isEmpty,
                 let bodyText = guideDescription.text, !bodyText.isEmpty else {
                     return
             }
        
             backendController.createPost(title: title, post: bodyText) { error in
                 if let error = error {
                     NSLog("Error posting posts: \(error)")
                     return
                 }
                 
                 DispatchQueue.main.async {
                     //Alert
                    
self.showAlertMessage(title: "Post Created!", message: "Congratulations!", actiontitle: "Ok")
                    self.performSegue(withIdentifier: "mainTableSegue", sender: self)
                  
                 }
                 
             }
    
             do {
                 try CoreDataStack.shared.mainContext.save()
             } catch {
                 NSLog("Error saving managed object context: \(error)")
                 return
             }
             navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
    
    func showAlertMessage(title: String, message: String, actiontitle: String) {
        let endAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let endAction = UIAlertAction(title: actiontitle, style: .default) { (action: UIAlertAction ) in
        }
        
        endAlert.addAction(endAction)
        present(endAlert, animated: true, completion: nil)
    }

}
extension CreateGuideViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginGuidesViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
