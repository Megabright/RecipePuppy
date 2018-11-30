//
//  RecipePuppyResult.swift
//  RecipePuppy
//
//  Created by mnu on 30/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

struct RecipePuppyResult {
    
    var title: String
    var version: Any
    var href: String
    var results: [RecipePuppy] = []
    
    init?(fromJson: [String: Any]) {
        
        guard
            let title = fromJson["title"] as? String,
            let version = fromJson["version"],
            let href = fromJson["href"] as? String,
            let results = fromJson["results"] as? [Any]
        
        else {
            return nil
        }
        
        self.title = title
        self.version = version
        self.href = href
        for result in results {
            self.results.append(RecipePuppy(fromJson: result as! [String : Any])!)
        }
        
    }
}
