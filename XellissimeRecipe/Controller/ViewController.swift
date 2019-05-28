//
//  ViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 27/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the navigationBar transparent
       // navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let url = "https://api.edamam.com/search?q=chicken&app_id=7ba6f788&app_key=58fb0a71d4b3042d003fa99123a86f75"
        
        Alamofire.request(url).responseJSON { (response) in
            if let myResponse = response.result.value as? [String : Any] {
                print(myResponse["count"] as Any)
            }
            print("rr")
          
        // Do any additional setup after loading the view.
    }
}
}
