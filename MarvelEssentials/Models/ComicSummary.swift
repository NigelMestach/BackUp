//
//  ComicSummary.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation
struct ComicSummary : Decodable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        
        
    }
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        /*        let valueContainer = try decoder.container(keyedBy: DataMarvel.CodingKeys.self).nestedContainer(keyedBy: Result.CodingKeys.self, forKey: .result).nestedContainer(keyedBy: Character.CodingKeys.self, forKey: .characters)*/
        /*decoder.container(keyedBy:DataMarvel.CodingKeys.self).nestedContainer(keyedBy: Result.CodingKeys.self, forKey: .result).nestedContainer(keyedBy: Character.CodingKeys.self, forKey: .characters)*/
        
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        // self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        
    }
    
}
