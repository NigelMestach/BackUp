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
        
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        
    }
    
}
