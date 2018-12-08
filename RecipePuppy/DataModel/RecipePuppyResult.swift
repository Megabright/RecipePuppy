//
//  RecipePuppyResult.swift
//  RecipePuppy
//
//  Created by mnu on 30/11/2018.
//  Copyright © 2018 mundaco.com. All rights reserved.
//

struct RecipePuppyResult: Codable {
    
    let title: String
    let version: Float
    let href: String
    let results: [RecipePuppy]
    
}
