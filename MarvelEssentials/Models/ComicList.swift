//
//  ComicList.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation

struct ComicList : Decodable {
    
    var items: [ComicSummary]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
       
        
    }
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        /*        let valueContainer = try decoder.container(keyedBy: DataMarvel.CodingKeys.self).nestedContainer(keyedBy: Result.CodingKeys.self, forKey: .result).nestedContainer(keyedBy: Character.CodingKeys.self, forKey: .characters)*/
        /*decoder.container(keyedBy:DataMarvel.CodingKeys.self).nestedContainer(keyedBy: Result.CodingKeys.self, forKey: .result).nestedContainer(keyedBy: Character.CodingKeys.self, forKey: .characters)*/
        self.items = try valueContainer.decode([ComicSummary].self, forKey: CodingKeys.items)
        
        // self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        
    }
    
    
}
