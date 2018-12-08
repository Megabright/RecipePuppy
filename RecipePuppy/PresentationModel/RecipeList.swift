//
//  RecipeList.swift
//  RecipePuppy
//
//  Created by mnu on 08/12/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

extension Array where Element: Recipe {
    static func map(recipes: [RecipePuppy]) -> [Recipe] {
        var list: [Recipe] = []
        for recipe in recipes {
            list.append(Recipe(with: recipe))
        }
        return list
    }
}
