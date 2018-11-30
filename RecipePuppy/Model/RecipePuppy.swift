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

    init?(fromJson: [String: Any]) {
        guard
            let title = fromJson["title"] as? String,
            let href = fromJson["href"] as? String,
            let ingredients = fromJson["ingredients"] as? String,
            let thumbnail = fromJson["thumbnail"] as? String
            else {
                return nil
        }
        
        self.title = title
        self.href = href
        self.ingredients = ingredients
        self.thumbnail = thumbnail
    }
}
