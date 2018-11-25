//
//  CharacterDataContainer.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation

struct CharacterDataContainer : Decodable{
    var results : [Character]
    enum CodingKeys: String, CodingKey {
        case results = "results"
        
    }
    /*
     init(from decoder: Decoder) throws {
     let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
     self.results = try valueContainer.decode([Character].self,
     forKey: CodingKeys.results)
     
     }*/
    
}
