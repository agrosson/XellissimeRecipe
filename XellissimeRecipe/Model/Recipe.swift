//
//  Recipe.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 28/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation


var listOfRecipes = [MyRecipe]()

class MyRecipe {
    var name : String
    var urlPhoto = String()
    var urlRecipeDetail = String()
    var ingredient = [String]()
    var cookingTime = Int()
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}
