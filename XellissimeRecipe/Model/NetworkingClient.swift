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
    
    func search(with ingredients: [String]){
        var items = ""
        for ingredient in ingredients{
            items += "+\(ingredient)"
        }
        let appId = valueForAPIKey(named: "APIEdamamId")
        let appKey = valueForAPIKey(named: "APIEdamamKeys")
        let url = "https://api.edamam.com/search?q=\(items)&app_id=\(appId)&app_key=\(appKey)"
        
        Alamofire.request(url).responseJSON { (response) in
            if let myResponse = response.result.value as? [String : Any] {
                print(myResponse["count"] as Any)
                print(myResponse)
            }
        }
    }
}
