//
//  NetworkingClient.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 28/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    
    static var shared = NetworkingClient()
    private init() {}
    
    var listOfRecipes = [MyRecipe]()
    
    // MARK: - Methods
    /**
     Alamofire request to Edamam API, with list of ingredients in the request
     - Parameter ingredients: an array of ingredients (String)
     */
    func search(with ingredients: [String]){
        listOfRecipes = [MyRecipe]()
        var items = ""
        for ingredient in ingredients {
            items += "+\(ingredient)"
        }
        let appId = valueForAPIKey(named: "APIEdamamId")
        let appKey = valueForAPIKey(named: "APIEdamamKeys")
        // Number of response si limited to 20
        let url = "https://api.edamam.com/search?q=\(items)&app_id=\(appId)&app_key=\(appKey)&to=3"
        Alamofire.request(url).responseJSON { (response) in
            guard let myResponse = response.result.value as? [String : Any] else {return}
            guard let hits = myResponse["hits"] as? [[String : Any]] else {return}
            print("là")
            print(hits.count)
            let numberOfResponse = hits.count
            for number in 0..<numberOfResponse {
                let recipeToShow = MyRecipe(name: "")
                guard let recipeDetails = hits[number]["recipe"] as? [String : Any] else {return}
                guard let recipeName = recipeDetails["label"] as? String else {return}
                print("Victoire on a le nom de la recette \(recipeName)")
                recipeToShow.name = recipeName
                guard let recipeImage = recipeDetails["image"] as? String else {return}
                print("le lien de l'image est le suivant : \(recipeImage)")
                recipeToShow.urlPhoto = recipeImage
                guard let recipePrepare = recipeDetails["url"] as? String else {return}
                print("le lien de la recette est le suivant : \(recipePrepare)")
                recipeToShow.urlRecipeDetail = recipePrepare
                guard let recipeIngredients = recipeDetails["ingredientLines"] as? [String] else {return}
                for individualIngredient in recipeIngredients {
                    print(individualIngredient)
                    recipeToShow.ingredient.append(individualIngredient)
                }
                guard let recipeTime = recipeDetails["totalTime"] as? Int else {return}
                print("le temps de préparation est de : \(recipeTime) minutes")
                recipeToShow.cookingTime = recipeTime
                self.listOfRecipes.append(recipeToShow)
            }
        }
    }
}



