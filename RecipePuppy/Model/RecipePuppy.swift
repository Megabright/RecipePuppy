//
//  Recipe.swift
//  RecipePuppy
//
//  Created by mnu on 29/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

struct RecipePuppy {
    
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String
    let thumbnailData: Data?

    init?(fromJson: [String: Any]) {
        guard
            let title = fromJson["title"] as? String,
            let href = fromJson["href"] as? String,
            let ingredients = fromJson["ingredients"] as? String,
            let thumbnail = fromJson["thumbnail"] as? String
            else {
                return nil
        }
        
        self.title = title.stringByDecodingHTMLEntities
        self.href = href
        self.ingredients = ingredients
        self.thumbnail = thumbnail
        
        var imageData: Data? = nil
        if(self.thumbnail != "") {
            do {
                imageData = try Data(contentsOf: URL(string: (self.thumbnail))!)
            } catch {
                
            }
        }
        self.thumbnailData = imageData
    }
}
