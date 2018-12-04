//
//  RecipeDetailPresenter.swift
//  RecipePuppy
//
//  Created by mnu on 04/12/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

import Foundation

class RecipeDetailPresenter {
    
    //Model
    var recipe: RecipePuppy?
    
    init(with recipe: RecipePuppy) {
        self.recipe = recipe
    }
    
    var title: String {
        return recipe!.title
    }
    
    var thumbnailData: Data? {
        return recipe!.thumbnailData
    }
    
    var ingredients: String {
        return recipe!.ingredients
    }
}
