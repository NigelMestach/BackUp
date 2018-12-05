//
//  Bookmark.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 05/12/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation

class Bookmarks: Codable{
    
    var comics: [String] = []
    
    func addBookmark(comic: String){
        comics.append(comic)
    }
    
    func removeBookmark(comic: Int){
        comics.remove(at: comic)
    }
    
    
}
