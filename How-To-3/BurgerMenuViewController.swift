//
//  BurgerMenuViewController.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 5/1/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

class BurgerMenuViewController: UIViewController {

    var backandController = BackendController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.dismiss(animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LogoutUnwindSegue", sender: self)
        backandController.signOut()
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
