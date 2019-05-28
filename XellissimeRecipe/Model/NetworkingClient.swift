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
        let url = "https://api.edamam.com/search?q=\(items)&app_id=7ba6f788&app_key=58fb0a71d4b3042d003fa99123a86f75"
        
        Alamofire.request(url).responseJSON { (response) in
            if let myResponse = response.result.value as? [String : Any] {
                print(myResponse["count"] as Any)
                print(myResponse)
            }
        }
    }
}
