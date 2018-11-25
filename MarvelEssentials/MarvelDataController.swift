//
//  MarvelDataController.swift
//  MarvelEssentials
//
//  Created by Nigel Mestach on 24/11/2018.
//  Copyright © 2018 Nigel Mestach. All rights reserved.
//

import Foundation
import UIKit


class MarvelDataController{
    
    static let sharedController = MarvelDataController()
    
    let baseURL = URL(string: "https://gateway.marvel.com/v1/public/characters")!
    
    func fetchFullData(completion: @escaping (DataMarvel) -> Void)
    {
        let timestamp = String(Date().toTimeStamp())
        let hash = timestamp+"43618d074125e4ca97283c68601102b724e8b2d4"+"0fdac27ed5044f2ffc9aca8081c1ccf5"
        let query: [String: String] = [
            "ts": timestamp,
            "apikey": "0fdac27ed5044f2ffc9aca8081c1ccf5",
            "hash": String(hash.utf8.md5),
            "limit": String(100),
            "events": "310"
            
        ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = baseURL.withQueries(query)!
        let jsonDecoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            try? jsonDecoder.decode(DataMarvel.self, from: data!)
            if let data = data,
                let marvel = try? jsonDecoder.decode(DataMarvel.self, from: data) {
                print("gelukt")
                completion(marvel)
            } else {
                print("failed")
                
            }
            
            
        }
        task.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
    }
    
    
}

extension Date {
    func toTimeStamp() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
