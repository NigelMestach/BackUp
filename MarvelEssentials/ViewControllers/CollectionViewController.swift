//
//  CollectionViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 29/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit




class CollectionViewController: UICollectionViewController {
let reuseIdentifier = "characterColCell"
var characters: [Character] = []
    override func viewDidLoad() {
        print("loaded")
        super.viewDidLoad()
        getAndCheck()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
     //   self.collectionView!.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    func getAndCheck() {
        MarvelDataController.sharedController.fetchFullData { (container, error) in
            if error {
                
                // label in table
                DispatchQueue.main.async {
                    
                    // pop up
                    let alert = UIAlertController(title: "Warning", message: "There is no connection to the Marvel Database", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                
            } else {
                DispatchQueue.main.async {
                self.characters = (container?.data.results)!
                
                self.collectionView.reloadData()
                    print(self.characters)
                }
            }
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if characters.count == 0 {
            getAndCheck()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if characters.count == 0 {
            return 0
        } else {
            return characters.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
    
        // Configure the cell
        
        let character = characters[indexPath.row]
        cell.position = indexPath.row
        let picURL = character.thumbnail.path + "/standard_xlarge." + character.thumbnail.exten
        cell.image.layer.cornerRadius = 75
        cell.image.clipsToBounds = true
        //image
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: picURL)!
        let task = URLSession.shared.dataTask(with: url.withHTTPS()!) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.characters[indexPath.row].cache = UIImage(data: data)
                cell.image.image = self.characters[indexPath.row].cache
                cell.nameLabel.text = character.name
            }
        }
        task.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
    
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "CharacterSegue" {
            let characterDetails = segue.destination as!
            CharacterDetailsViewController
            let cell = sender as! CharacterCollectionViewCell
            characterDetails.character = characters[(cell.position)!]
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
