//
//  RecipePuppyRequest.swift
//  RecipePuppy
//
//  Created by mnu on 30/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation
import HTMLString

struct RecipePuppyRequest {
    
    private var _query: String = ""
    var query: String {
        get {
            return self._query
        }
        set {
            // Reset page to 1 if the search text is changed
            if(self._query != newValue) {
                self._page = 1
            }
            
            self._query = newValue
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
        self.query = search
        self.page = page
        self.ingredients = ingredients
    }
    
    func toQueryString() -> [String: Any] {
        return ["q": self.query.addingUnicodeEntities, "p": self.page, "i": self.ingredients.joined(separator: ",")]
        
    }
}
