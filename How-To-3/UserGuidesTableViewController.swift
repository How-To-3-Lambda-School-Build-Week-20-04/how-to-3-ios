//
//  UserGuidesTableViewController.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/30/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

protocol PostSelectionDelegate: class {
    func postWasSelected(post: Post)
}
class UserGuidesTableViewController: UITableViewController {

    weak var delegate: PostSelectionDelegate?
    let backendController = BackendController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return backendController.userPosts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return backendController.userPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGuidesCell", for: indexPath) as? UserGuidesTableViewCell else { return UITableViewCell() }
        cell.post = backendController.userPosts[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let post = backendController.userPosts[indexPath.row]
        delegate?.postWasSelected(post: post)
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            let post = backendController.userPosts[indexPath.row]
//            backendController.deletePost(post: post) { result, error in
//                if let error = error {
//                    self.showAlertMessage(title: "Something wen't wrong", message: "Couldn't delete the guide", actiontitle: "Ok")
//                return
//                }
//
//
//            }
//
//        }
//    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "UserPostShowSegue" {
            if let detailVC = segue.destination as? GuidesDetailViewController,
                           let indexPath = tableView.indexPathForSelectedRow {
                detailVC.post = backendController.userPosts[indexPath.row]
            }
        }
    }
    

}
extension UserGuidesTableViewController {
    func showAlertMessage(title: String, message: String, actiontitle: String) {
         let endAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let endAction = UIAlertAction(title: actiontitle, style: .default) { (action: UIAlertAction ) in
         }
         
         endAlert.addAction(endAction)
         present(endAlert, animated: true, completion: nil)
     }
}
