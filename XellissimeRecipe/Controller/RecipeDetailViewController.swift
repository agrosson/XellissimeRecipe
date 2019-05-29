//
//  RecipeDetailViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe: MyRecipe!
    
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = recipe.name
        // Do any additional setup after loading the view.
    }

    
}
