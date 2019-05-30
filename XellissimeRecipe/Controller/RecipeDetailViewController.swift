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
    @IBOutlet weak var recipeDescription: UILabel!
    
    @IBOutlet weak var favoriteStar: UIButton!
    
    @IBOutlet weak var recipePicture: UIImageView!
    
    @IBOutlet weak var recipeOnSafari: UIButton!
    
    @IBAction func favoriteIsPressed(_ sender: UIButton) {
    }
    
    @IBAction func seeRecipeIsPressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScreen()
    }
    
    private func setupScreen(){
        name.text = recipe.name
        var text = ""
        for item in recipe.ingredient {
            text += "\t\(item)\n"
        }
        recipeDescription.text = text
       // recipePicture.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        recipePicture.translatesAutoresizingMaskIntoConstraints = false
        let width = UIScreen.main.bounds.width/8
        print("la largeur est de \(width)")
        //recipePicture.widthAnchor.constraint(equalToConstant: width).isActive = true
       // recipePicture.heightAnchor.constraint(equalToConstant: width).isActive = true
        recipePicture.leftAnchor.constraint(equalTo: view.leftAnchor, constant: width).isActive = true
        recipePicture.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -width).isActive = true
        var imageToDisplay : UIImage?
        let url = URL(string: recipe.urlPhoto )
        let data = try? Data(contentsOf: url!)
        imageToDisplay = UIImage(data: data!)
        if let myImage = imageToDisplay {
            recipePicture.image = myImage
        } else {
            guard let basicImage = UIImage(named: "straw") else {return}
            recipePicture.image = basicImage
        }
        recipeOnSafari.layer.borderWidth = 3
        recipeOnSafari.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        recipeOnSafari.layer.cornerRadius = 15
        
    }
}