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
 
        self.items = try valueContainer.decode([ComicSummary].self, forKey: CodingKeys.items)
        
    }
    
    
}
