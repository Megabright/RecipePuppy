//
//  RecipePuppyQuery.swift
//  RecipePuppy
//
//  Created by mnu on 30/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

struct RecipePuppyQuery {
    
    private var _search: String = ""
    var search: String {
        get {
            return self._search
        }
        set {
            // Reset page to 1 if the search text is changed
            if(self._search != newValue) {
                self._page = 1
            }
            
            self._search = newValue
        }
    }
    
    private var _page: Int = 1
    var page: Int {
        get {
            return self._page
        }
        set {
            // Dont allow page to be less than 1
            self._page = newValue < 1 ? 1 : newValue
        }
    }
    var ingredients: [String] = []
    
    
    init(search: String, page: Int = 1, ingredients: [String] = []) {
        self.search = search
        self.page = page
        self.ingredients = ingredients
    }
    
    func toQueryString() -> [String: Any] {
        return ["q": self.search, "p": self.page, "i": self.ingredients.joined(separator: ",")]
        
    }
}
