//
//  CharacterDetailsViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var character: Character!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = character.name
        let picURL = character.thumbnail.path + "/standard_xlarge." + character.thumbnail.exten
        updateUI(urlstr: picURL, imageView: imageView, description: character.description)
        

        // Do any additional setup after loading the view.
    }
    
    func updateUI(urlstr: String, imageView: UIImageView, description: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: urlstr)!
        let task = URLSession.shared.dataTask(with: url.withHTTPS()!) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                /*
                imageView.layer.cornerRadius = imageView.frame.size.width / 2.55
                imageView.clipsToBounds = true */
                if description != "" {
                self.descriptionLabel.text = description
                } else {
                    self.descriptionLabel.text = "There is no description for " + self.title! + "."
                }
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.updateTable()
            }
        }
        task.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print(character.comics.items)
    }
    
    func updateTable(){
        if self.character.comics.items.count == 0 {
            let noComics: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            noComics.text          = "No comics, come back later"
            noComics.textAlignment = .center
            noComics.textColor     = UIColor.gray
            self.tableView.backgroundView  = noComics
            self.tableView.separatorStyle  = UITableViewCell.SeparatorStyle.none
            self.tableView.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.comics.items.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCell", for: indexPath as IndexPath)
        let comic = character.comics.items[indexPath.row]
        cell.textLabel?.text = comic.name
        return cell
    }
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
