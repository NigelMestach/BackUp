//
//  BookmarkTableViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 23/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit

class BookmarkTableViewController: UITableViewController {
    
    var bookmarks : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        bookmarks = MarvelDataController.sharedController.bookmarks
        checkIfEmpty()
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarks = MarvelDataController.sharedController.bookmarks
        checkIfEmpty()
        self.tableView.reloadData()
        
    }
    
    func checkIfEmpty(){
        //niet in thread anders is de seperator er niet
        DispatchQueue.main.async {
            
            let noBookmarks: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            if self.bookmarks.count == 0 {
                noBookmarks.text          = "Add comics to bookmark them"
                noBookmarks.textAlignment = .center
                noBookmarks.textColor     = UIColor.gray
                self.tableView.backgroundView  = noBookmarks
                self.tableView.separatorStyle  = UITableViewCell.SeparatorStyle.none
                self.tableView.reloadData()
            } else {
                let labels = self.view.subviews.compactMap { $0 as? UILabel }
                
                for label in labels {
                    label.text=""
                }
                self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            }
        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section != 0 {
            return 0
        } else {
            return bookmarks.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath)
        cell.textLabel?.text = bookmarks[indexPath.row]
        cell.showsReorderControl = true
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) ->
        UITableViewCell.EditingStyle {
            return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            MarvelDataController.sharedController.bookmarks.remove(at: indexPath.row)
            MarvelDataController.sharedController.saveBookmarks()
            
            checkIfEmpty()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moved = MarvelDataController.sharedController.bookmarks.remove(at: fromIndexPath.row)
        MarvelDataController.sharedController.bookmarks.insert(moved, at: to.row)
        bookmarks = MarvelDataController.sharedController.bookmarks
        MarvelDataController.sharedController.saveBookmarks()
        tableView.reloadData()
        
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
