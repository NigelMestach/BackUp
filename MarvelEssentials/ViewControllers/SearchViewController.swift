//
//  SearchViewController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 25/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.isEnabled = false
        searchField.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "searchSegue" {
            let searchNav = segue.destination as! UINavigationController
            let searchTable = searchNav.topViewController as! SearchResultsTableViewController
            searchTable.keyword = searchField.text
            searchField.text?.removeAll()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func searchChanged(_ sender: Any) {
        let text = searchField.text ?? ""
        submitButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func unwindToSearch(segue: UIStoryboardSegue) {
    submitButton.isEnabled = false
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
