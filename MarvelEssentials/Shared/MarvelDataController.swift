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
    var bookmarks : [String] = []
    
    func fetchFullData(completion: @escaping (DataMarvel?, Bool) -> Void)
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
                
                if let data = data {
                    let marvel = try? jsonDecoder.decode(DataMarvel.self, from: data)
                    completion(marvel, false)
                } else {
                    print("failed")
                    completion(nil, true)
                    
                }
          
            
            
        }
        task.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
    }
    
    func fetchSearchedData(keyword: String, completion: @escaping (DataMarvel?, Bool) -> Void)
    {
        let timestamp = String(Date().toTimeStamp())
        let hash = timestamp+"43618d074125e4ca97283c68601102b724e8b2d4"+"0fdac27ed5044f2ffc9aca8081c1ccf5"
        let query: [String: String] = [
            "ts": timestamp,
            "apikey": "0fdac27ed5044f2ffc9aca8081c1ccf5",
            "hash": String(hash.utf8.md5),
            "limit": String(100),
            "nameStartsWith": String(keyword)
            
        ]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = baseURL.withQueries(query)!
        let jsonDecoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data {
                let marvel = try? jsonDecoder.decode(DataMarvel.self, from: data)
                print("succes keyword")
                completion(marvel, false)
            } else {
                completion(nil, true)
                
            }
            
            
        }
        task.resume()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
    }
    
    func addBookmark(comic: String){
        bookmarks.append(comic)
    }
    
    func removeBookmark(comic: Int){
        bookmarks.remove(at: comic)
    }
}

extension Date {
    func toTimeStamp() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
