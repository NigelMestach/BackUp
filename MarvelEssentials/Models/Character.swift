//
//  Character.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation
import UIKit

struct Character: Decodable {
    var name: String
    var description: String
    var thumbnail : Image
    var comics: ComicList
    var cache: UIImage?
    //var url: Image
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case thumbnail = "thumbnail"
        case comics = "comics"
        //case url = "thumbnail"
        
    }
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        /*        let valueContainer = try decoder.container(keyedBy: DataMarvel.CodingKeys.self).nestedContainer(keyedBy: Result.CodingKeys.self, forKey: .result).nestedContainer(keyedBy: Character.CodingKeys.self, forKey: .characters)*/
        /*decoder.container(keyedBy:DataMarvel.CodingKeys.self).nestedContainer(keyedBy: Result.CodingKeys.self, forKey: .result).nestedContainer(keyedBy: Character.CodingKeys.self, forKey: .characters)*/
        if let name = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.name) {
            self.name = name
        } else {
            self.name = ""
        }
        if let description = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            self.description = ""
        }
        self.thumbnail = try valueContainer.decode(Image.self, forKey: CodingKeys.thumbnail)
        self.comics = try valueContainer.decode(ComicList.self, forKey: CodingKeys.comics)
        
        // self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        
    }
}
