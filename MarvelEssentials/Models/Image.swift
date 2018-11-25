//
//  Image.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation

struct Image: Decodable {
    var path : String
    var exten : String
    
    enum CodingKeys: String, CodingKey{
        case path = "path"
        case exten = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        
        if let path = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.path) {
            self.path = path
        } else {
            self.path = ""
        }
        if let exten = try valueContainer.decodeIfPresent(String.self, forKey: CodingKeys.exten) {
            self.exten = exten
        } else {
            self.exten = ""
        }
    }
    
}
