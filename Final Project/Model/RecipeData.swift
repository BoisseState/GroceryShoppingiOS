//
//  RecipeData.swift
//  Final Project
//
//  Created by Joe Boisse on 11/25/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import Foundation

struct RecipeData : Decodable {
    let hits : [Hit]
    
    private enum CodingKeys: String, CodingKey {
        case hits
    }
    
    struct Hit: Decodable {
        let recipe : Recipe
        private enum CodingKeys: String, CodingKey {
            case recipe
        }
    }
}


struct Recipe : Decodable {
    let source : String
    let label : String
    let url : String
    let image : String
    let yield : Int
    let ingredients : [String]
    
    private enum CodingKeys: String, CodingKey {
        case source
        case label
        case url
        case image
        case yield
        case ingredients = "ingredientLines"
    }
    
    /*struct Ingredient : Decodable {
        let item : String
        private enum CodingKeys: String, CodingKey {
            case item
        }
    }*/
}


class RecipeInfo {
    let publisher : String
    let title : String
    let sourceURL : String
    let imageURL : String
    var imageData : Data?
    let yield : Int
    let ingredients : [String]
    
    init(recipe:Recipe) {
        self.publisher = recipe.source
        self.title = recipe.label
        self.sourceURL = recipe.url
        self.imageURL = recipe.image
        self.imageData = nil
        self.yield = recipe.yield
        self.ingredients = recipe.ingredients
    }
    
}
