//
//  Recipe.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 28/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation


// MARK: - Class MyRecipe
/**
 This class describes a recipe
 */
class MyRecipe {
    /// Name of the recipe
    var name : String
    /// Url to be used to display photo of the recipe
    var urlPhoto = String()
    /// Url to be used to display the full recipe with directions on internet
    var urlRecipeDetail = String()
    /// Array of ingredients for the recipe
    var ingredient = [String]()
    /// Cooking time necessary to make the meal
    var cookingTime = Int()
    /// Init function
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

/// Global variable, list of recipes that will be displayed in tableviews
var listOfRecipes = [MyRecipe]()
