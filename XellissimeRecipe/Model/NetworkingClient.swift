//
//  NetworkingClient.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 28/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import Alamofire


// MARK: - Class NetworkingClient
/**
 This class enables to send request to Edamam API with Alamofire
 */
class NetworkingClient {
    //MARK: - Properties
    /// Singleton variable for NetworkingClient
    static var shared = NetworkingClient()
    //MARK: -
    private init() {}
    // MARK: - Methods
    /**
     This function creates a url string to be used with Alamofire with the list of ingredients
     - Parameter ingredients: an array of ingredients (String)
     */
    func createURL(with ingredients: [String]) -> String {
        listOfRecipes = [MyRecipe]()
        var items = ""
        for ingredient in ingredients {
            items += "+\(ingredient)"
        }
        let appId = valueForAPIKey(named: "APIEdamamId")
        let appKey = valueForAPIKey(named: "APIEdamamKeys")
        // Number of response si limited to 30
        let url = "https://api.edamam.com/search?q=\(items)&app_id=\(appId)&app_key=\(appKey)&to=30"
        return url
    }
    /**
     Alamofire request to Edamam API, with list of ingredients in the request
     - Parameter url: the url to be used for API Edamam (String)
     */
    func search(with url: String, callBack: @escaping (Bool, [MyRecipe]?) -> ()){
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
}



