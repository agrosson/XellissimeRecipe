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
        let url = "https://api.edamam.com/search?q=\(items)&app_id=\(appId)&app_key=\(appKey)&to=20"
        Alamofire.request(url).responseJSON { (response) in
            if let myResponse = response.result.value as? [String : Any] {
                if let hits = myResponse["hits"] as? [[String : Any]] {
                    print("là")
                    print(hits.count)
                    let numberOfResponse = hits.count
                    for number in 0..<numberOfResponse {
                        let recipeToShow = MyRecipe(name: "")
                        if let recipeDetails = hits[number]["recipe"] as? [String : Any] {
                            if let recipeName = recipeDetails["label"] as? String {
                                print("Victoire on a le nom de la recette \(recipeName)")
                                recipeToShow.name = recipeName
                            }
                            if let recipeImage = recipeDetails["image"] as? String {
                                print("le lien de l'image est le suivant : \(recipeImage)")
                                recipeToShow.urlPhoto = recipeImage
                            }
                            if let recipeDetails = recipeDetails["url"] as? String {
                                print("le lien de la recette est le suivant : \(recipeDetails)")
                                recipeToShow.urlRecipeDetail = recipeDetails
                            }
                        }
                    }
                   
                }

            }
        }
    }
}
