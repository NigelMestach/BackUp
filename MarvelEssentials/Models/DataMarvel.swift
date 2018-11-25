//
//  File.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation


struct DataMarvel : Decodable {
    var data : CharacterDataContainer
    var code : Int
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case data = "data"
        //case total
    }
    /*
     init(from decoder: Decoder) throws {
     let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
     self.code = try valueContainer.decode(Int.self,
     forKey: CodingKeys.code)
     self.data = try valueContainer.decode(CharacterDataContainer.self, forKey: CodingKeys.data)
     }
     */
    
}
