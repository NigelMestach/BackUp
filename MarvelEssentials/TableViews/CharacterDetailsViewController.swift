//
//  CharacterDetailsViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let datacontroller = MarvelDataController.sharedController
    var character: Character!
    var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = character.name
        let picURL = character.thumbnail.path + "/standard_xlarge." + character.thumbnail.exten
        activityIndicatorView.startAnimating()
        updateUI(urlstr: picURL, imageView: imageView, description: character.description)

    }
    
    override func loadView() {
        super.loadView()
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        
        tableView.backgroundView = activityIndicatorView
    }
    
    func updateUI(urlstr: String, imageView: UIImageView, description: String) {
        if let photo = character.cache {
            
            imageView.image = photo
            updateText(description)
            
        } else {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: urlstr)!
        let task = URLSession.shared.dataTask(with: url.withHTTPS()!) { data, _, _ in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    let alert = UIAlertController(title: "Warning", message: "There is no connection to the Marvel Database", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                return
                
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                /*
                 imageView.layer.cornerRadius = imageView.frame.size.width / 2.55
                 imageView.clipsToBounds = true */
                self.updateText(description)
            }
        }
        task.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.updateTable()
    }
    
    func updateText(_ description: String){
        self.activityIndicatorView.stopAnimating()
        if description != "" {
            self.descriptionLabel.text = description
        } else {
            self.descriptionLabel.text = "There is no description for " + self.title! + "."
        }
        
        
        
        
    }
    func updateTable(){
        DispatchQueue.main.async {
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
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.comics.items.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCell", for: indexPath as IndexPath) as! ComicTableViewCell
        let comic = character.comics.items[indexPath.row]
        cell.comicLabel?.text = comic.name
        if !MarvelDataController.sharedController.bookmarks.contains(comic.name){
            cell.savedButton?.setTitle("➕", for: .normal)
        } else {
            cell.savedButton?.setTitle("✔️", for: .normal)
        }
        return cell
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
//        DispatchQueue.main.async {
//
            let cell = sender.superview?.superview?.superview as? ComicTableViewCell
        
            //animation
            
            UIView.animate(withDuration: 0.6,
                           animations: {
                            sender.transform = CGAffineTransform(rotationAngle: 360)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.6) {
                                sender.transform = CGAffineTransform.identity
                            }
            })
        
            let comic = cell?.comicLabel.text
            let bookmark = datacontroller.bookmarks
            if !bookmark.contains(comic!){
                datacontroller.saveToBookmarks(comic!)
                let indexpath = self.tableView.indexPath(for: cell!)
                self.tableView.reloadRows(at: [indexpath!], with: .automatic)
            } else {
                let position = bookmark.firstIndex(of: comic!)
                datacontroller.bookmarks.remove(at: position!)
                datacontroller.saveBookmarks()
                let indexpath = self.tableView.indexPath(for: cell!)
                self.tableView.reloadRows(at: [indexpath!], with: .automatic)
            }
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
