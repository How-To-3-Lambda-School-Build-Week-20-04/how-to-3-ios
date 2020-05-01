//
//  LoginGuidesViewController.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/30/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class LoginGuidesViewController: UIViewController {
    
    // MARK: - Properties
    var backendController = BackendController.shared
    
    // MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var logInLabel: UIButton!
    @IBOutlet private weak var registerLabel: UIButton!
    
    // MARK: - Custom Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.isHidden = true
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Sign Up
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        emailTextField.isHidden = false
        logInLabel.setTitle("Cancel", for: .normal)
        
        
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            username.isEmpty == false,
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            password.isEmpty == false,
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            else { return }
        backendController.signUp(username: username, password: password, email: email) { signUpResult, response, error  in
            
            if signUpResult {
                DispatchQueue.main.async {
                    self.showAlertMessage(title: "Success", message: "You Signed Up Successfully", actiontitle: "Ok")
                }
                return
            }

            if let error = error {
                //                Alert
                self.showAlertMessage(title: "Try again!", message: "Error signing up!", actiontitle: "Ok")
                return
            }
            if let response = response {
                 self.showAlertMessage(title: "Try with different user", message: "Existing User.", actiontitle: "Ok")
                return
            }
            
            
        }
        if self.logInLabel.isSelected == false {
            self.logInLabel.setTitle("Sign In", for: .normal)
        }
        
    }
    
    
    // MARK: - Sign IN
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            username.isEmpty == false,
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            password.isEmpty == false else { return }
        emailTextField.isHidden = true
        
        backendController.signIn(username: username, password: password) { signIn in
 
            DispatchQueue.main.async {
                
                  let action: () -> Void
                
                if signIn {
                      self.performSegue(withIdentifier: "LoggedInShowSegue", sender: self)
                    self.showAlertMessage(title: "Success", message: "Succesfully logged in", actiontitle: "Ok")
                } else {
                    action = { self.showAlertMessage(title: "Retry", message: "Problem in signing in", actiontitle: "Ok") }
                    
            }
//                action()
        }
    }
    }
    
    
    func showAlertMessage(title: String, message: String, actiontitle: String) {
        let endAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let endAction = UIAlertAction(title: actiontitle, style: .default) { (action: UIAlertAction ) in
        }
        
        endAlert.addAction(endAction)
        present(endAlert, animated: true, completion: nil)
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
extension LoginGuidesViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginGuidesViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
