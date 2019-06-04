//
//  AlamofireFake.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 04/06/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import Alamofire
@testable import XellissimeRecipe

struct AlamofireFake {
    
   
    init() {}
    
    static var fakeMyResponse: Any?
    static var fakeHits: Any?
    static var fakeNumber = 1
    static var fakeRecipeToShow: Any?
    static var fakeRecipeDetails: Any?
    static var fakeRecipeName: Any?
    static var fakeRecipeImage: Any?
    static var fakeRecipePrepare: Any?
    static var fakeRecipeIngredients: Any?
    static var fakeRecipeTime: Any?
    
    
    // MARK: - Methods
    /**
     Alamofire request to Edamam API, with list of ingredients in the request
     - Parameter ingredients: an array of ingredients (String)
     */
    static func search(with ingredients: [String], callBack: @escaping (Bool, [MyRecipe]?) -> ()){
        
        listOfRecipes = [MyRecipe]()
        var items = ""
        for ingredient in ingredients {
            items += "+\(ingredient)"
        }
        let appId = valueForAPIKey(named: "APIEdamamId")
        let appKey = valueForAPIKey(named: "APIEdamamKeys")
        // Number of response si limited to 30
        let url = "https://api.edamam.com/search?q=\(items)&app_id=\(appId)&app_key=\(appKey)&to=30"
        Alamofire.request(url).responseJSON { (responseFake) in
            DispatchQueue.main.async {
                guard (AlamofireFake.fakeMyResponse as? [String : Any]) != nil else { callBack(false, nil);return}
                guard (AlamofireFake.fakeHits as? [[String : Any]]) != nil else { callBack(false, nil);return}
                let numberOfResponse = AlamofireFake.fakeNumber
                for _ in 0..<numberOfResponse {
                    guard (AlamofireFake.fakeRecipeToShow != nil) else { callBack(false, nil);return}
                    guard (AlamofireFake.fakeRecipeDetails as? [String : Any]) != nil else { callBack(false, nil);return}
                    guard (AlamofireFake.fakeRecipeName as? String) != nil else { callBack(false, nil);return}
                    guard (AlamofireFake.fakeRecipeImage as? String) != nil else { callBack(false, nil);return}
                    guard (AlamofireFake.fakeRecipePrepare as? String) != nil else { callBack(false, nil);return}
                    guard (AlamofireFake.fakeRecipeIngredients as? [String]) != nil else { callBack(false, nil);return}
                    guard (AlamofireFake.fakeRecipeTime as? Int) != nil else { callBack(false, nil);return}
                }
                callBack(true, listOfRecipes);return}
        }
    }
    
    static func insertFakeData(){
        AlamofireFake.fakeMyResponse = FakeNetworkResponseData.responseOK
        AlamofireFake.fakeHits = FakeNetworkResponseData.hitsOK
        AlamofireFake.fakeNumber = FakeNetworkResponseData.numberOfResponseOK
        AlamofireFake.fakeRecipeToShow = FakeNetworkResponseData.recipeToShowOK
        AlamofireFake.fakeRecipeDetails = FakeNetworkResponseData.recipeDetailsOK
        AlamofireFake.fakeRecipeName = FakeNetworkResponseData.recipeNameOK
        AlamofireFake.fakeRecipeImage = FakeNetworkResponseData.recipeImageOK
        AlamofireFake.fakeRecipePrepare = FakeNetworkResponseData.recipePrepareOk
        AlamofireFake.fakeRecipeIngredients = FakeNetworkResponseData.recipeIngredientsOK
        AlamofireFake.fakeRecipeTime = FakeNetworkResponseData.recipeTimeOK
    }
    
}
