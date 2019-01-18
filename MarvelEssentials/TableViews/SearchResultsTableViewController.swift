//
//  SearchResultsTableViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 25/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {
    let datacontroller = MarvelDataController.sharedController
    var characters: [Character] = []
    var keyword : String!
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results for " + keyword
        activityIndicatorView.startAnimating()
        datacontroller.fetchSearchedData(keyword: keyword) { (container, error) in
            if error {
                let alert = UIAlertController(title: "Warning", message: "There is no connection to the Marvel Database", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            
            self.updateUI(characters: container?.data.results)
            
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //SOURCE : https://gkbrown.org/2015/12/07/displaying-an-activity-indicator-while-loading-data-in-the-background/
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        
        tableView.backgroundView = activityIndicatorView
    }
    
    func updateUI(characters : [Character]?){
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            if let characters = characters, characters.count > 0 {
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
    

}
