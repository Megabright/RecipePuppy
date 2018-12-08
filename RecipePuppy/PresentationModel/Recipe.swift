//
//  Recipe.swift
//  RecipePuppy
//
//  Created by mnu on 08/12/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import HTMLString

class Recipe {
    
    let title: String?
    let ingredients: String?
    let thumbnail: String?
    
    init(with title: String, ingredients: String, thumbnail: String) {
        self.title = title.removingHTMLEntities
        self.ingredients = ingredients
        self.thumbnail = thumbnail
    }
    
    convenience init(with recipe: RecipePuppy) {
        self.init(with: recipe.title, ingredients: recipe.ingredients, thumbnail: recipe.thumbnail)
    }
    
    fileprivate var _thumbnailData: Data? = nil
    var thumbnailData: Data? {
        get {
            if(_thumbnailData == nil) {
                var imageData: Data? = nil
                if(self.thumbnail != "") {
                    do {
                        let url = URL(string: (self.thumbnail!))
                        if(url != nil) {
                            imageData = try Data(contentsOf: url!)
                        }
                    } catch {
                        return nil
                    }
                }
                self._thumbnailData = imageData
            }
            return _thumbnailData
        }
    }
}
