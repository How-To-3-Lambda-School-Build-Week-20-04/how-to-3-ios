//
//  UserGuidesTableViewController.swift
//  How-To-3
//
//  Created by Bhawnish Kumar on 4/30/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit
import CoreData
class UserGuidesTableViewController: UITableViewController {
    
    let backendController = BackendController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backendController.forceLoadUserPosts { loaded, _ in
            if loaded {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return backendController.userPosts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGuidesCell", for: indexPath) as? UserGuidesTableViewCell else { return UITableViewCell() }
        cell.post = backendController.userPosts[indexPath.row]
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            // TODO: expected to decode Int but found dictionary instead.
            let post = backendController.userPosts[indexPath.row]
            
            backendController.deletePost(post: post) { result, error in
                if let error = error {
                    NSLog("error in deleting: \(error)")
                    return
                }
                if let result = result {
                    if result {
                        DispatchQueue.main.async {
                            if let indexOf = self.backendController.userPosts.firstIndex(of: post) {
                                self.backendController.userPosts.remove(at: indexOf)
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    }
                }
            }
            
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UserPostShowSegue" {
            if let detailVC = segue.destination as? GuidesDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                detailVC.post = backendController.userPosts[indexPath.row]
    detailVC.wasEdited = true 
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
extension UserGuidesTableViewController: NSFetchedResultsControllerDelegate {
    //     this is the warning the tableview that the fetch controller is goijng to makechanges in the tableview.
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        //        this is the beggnining of the fetchhing
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        //         the endo of the fetchhing.
    }
    //    deletes the entire section or insert entire section
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
}
