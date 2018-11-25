//
//  SearchResultsTableViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 25/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    var characters: [Character] = []
    var keyword : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results for " + keyword
        
        MarvelDataController.sharedController.fetchSearchedData(keyword: keyword) { (container) in
                self.updateUI(characters: container.data.results, container: container)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateUI(characters : [Character], container: DataMarvel){
        DispatchQueue.main.async {
            if container.data.results.count > 0{
            self.characters = characters
            self.tableView.reloadData()
            } else {
                let noResult: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
                noResult.text          = "No results for " + self.keyword
                noResult.textAlignment = .center
                noResult.textColor     = UIColor.gray
                self.tableView.backgroundView  = noResult
                self.tableView.separatorStyle  = UITableViewCell.SeparatorStyle.none
                self.tableView.reloadData()
            }
        }
        
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if characters.count == 0 {
            return 0
        } else {
            return characters.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCharacterCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        //temp hide labele
        cell.textLabel?.text = " "
        let character = characters[indexPath.row]
        let picURL = character.thumbnail.path + "/standard_small." + character.thumbnail.exten
        updateCell(urlstr: picURL, imageView: cell.imageView, textLabel : cell.textLabel, characterName: character.name )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "CharacterSegue" {
            let characterDetails = segue.destination as!
            CharacterDetailsViewController
            let index = tableView.indexPathForSelectedRow!.row
            characterDetails.character = characters[index]
        }
    }
    
    func updateCell(urlstr: String, imageView: UIImageView?, textLabel: UILabel?, characterName: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: urlstr)!
        let task = URLSession.shared.dataTask(with: url.withHTTPS()!) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                imageView?.image = UIImage(data: data)
                textLabel?.text = characterName
            }
        }
        task.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
