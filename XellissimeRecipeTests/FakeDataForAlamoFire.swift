//
//  FakeDataForAlamoFire.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 04/06/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import  CoreData
@testable import XellissimeRecipe


class FakeNetworkResponseData {
    // instance of response OK - statusCode 200
    static let responseOK = [String:String]()
    static let responseKO = "It's an error"
    
    static let hitsOK = [String:String]()
    static let hitsKO = "It's an error"
    
    static let numberOfResponseKO = 0
    static let numberOfResponseOK = 3
    
    static let recipeToShowOK = MyRecipe(name: "pizza")
    static let recipeToShowKO = 0
    
    
    static let recipeDetailsOK = [String:String]()
    static let recipeDetailsKO = "It's an error"
    
    
    static let recipeNameOK = "un string"
    static let recipeNameK0 = 0
    
    static let recipeImageOK = "un string"
    static let recipeImageKO = 0
    
    static let recipePrepareOk = "un string"
    static let recipePrepareKO = 0
    
    static let recipeIngredientsOK = [String]()
    static let recipeIngredientsKO = 0
    
    static let recipeTimeOK = 20
    static let recipeTimeKO = "bad"
    
    static let listOfRecipesOK = [MyRecipe]()
    static let listOfRecipesKO = "nothing"
}
/*
func search(with ingredients: [String], callBack: @escaping (Bool, [MyRecipe]?) -> ()){
    listOfRecipes = [MyRecipe]()
    var items = ""
    for ingredient in ingredients {
        items += "+\(ingredient)"
    }
    let appId = valueForAPIKey(named: "APIEdamamId")
    let appKey = valueForAPIKey(named: "APIEdamamKeys")
    // Number of response si limited to 30
    let url = "https://api.edamam.com/search?q=\(items)&app_id=\(appId)&app_key=\(appKey)&to=30"
    Alamofire.request(url).responseJSON { (response) in
        DispatchQueue.main.async {
            guard let myResponse = response.result.value as? [String : Any] else { callBack(false, nil);return}
            guard let hits = myResponse["hits"] as? [[String : Any]] else { callBack(false, nil);return}
            let numberOfResponse = hits.count
            for number in 0..<numberOfResponse {
                guard let recipeToShow = MyRecipe(name: " ") else { callBack(false, nil);return}
                guard let recipeDetails = hits[number]["recipe"] as? [String : Any] else { callBack(false, nil);return}
                guard let recipeName = recipeDetails["label"] as? String else { callBack(false, nil);return}
                recipeToShow.name = recipeName
                guard let recipeImage = recipeDetails["image"] as? String else { callBack(false, nil);return}
                recipeToShow.urlPhoto = recipeImage
                guard let recipePrepare = recipeDetails["url"] as? String else { callBack(false, nil);return}
                recipeToShow.urlRecipeDetail = recipePrepare
                guard let recipeIngredients = recipeDetails["ingredientLines"] as? [String] else { callBack(false, nil);return}
                for individualIngredient in recipeIngredients {
                    recipeToShow.ingredient.append(individualIngredient)
                }
                guard let recipeTime = recipeDetails["totalTime"] as? Int else { callBack(false, nil);return}
                recipeToShow.cookingTime = recipeTime
                listOfRecipes.append(recipeToShow)
            }
            callBack(true, listOfRecipes);return}
    }
}
*/
