//
//  RecipeDetailViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDetailViewController: UIViewController {

    var recipe: MyRecipe!
    var star = false
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var recipeDescription: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var favoriteStar: UIButton!
    
    @IBOutlet weak var recipePicture: UIImageView!
    
    @IBOutlet weak var recipeOnSafari: UIButton!
    
    @IBAction func favoriteIsPressed(_ sender: UIButton) {
        favoriteSwitch()
    }
    
    @IBAction func seeRecipeIsPressed(_ sender: Any) {
        showSafariVC(for: recipe.urlRecipeDetail)
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
        if star {
            favoriteStar.setImage(UIImage(named: "favoriteSelected"), for: .normal)
        }
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
        
        let time = recipe.cookingTime
        if  time == 0 {
            durationLabel.text = "No cooking time indication"
        } else {
            durationLabel.text = "Cooking time: \(time) minutes"
        }
        
    }
    private func showSafariVC(for url: String){
        guard let url = URL(string: url) else {
            print("error with url")
            // TODO create an alert
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
    }
    
    private func favoriteSwitch(){
        if favoriteStar.currentImage == UIImage(imageLiteralResourceName: "favoriteNotSelected") {
            favoriteStar.setImage(UIImage(named: "favoriteSelected"), for: .normal)
            star = true
            saveToFavorite(recipe: recipe)
            //Todo add in favorite
        } else {
            favoriteStar.setImage(UIImage(named: "favoriteNotSelected"), for: .normal)
        //    CoreRecipe.delete(recipe)
            star = false
            //Todo remove from favorite
        }
    }
    
    private func saveToFavorite(recipe: MyRecipe){
        let savedRecipe = CoreRecipe(context: AppDelegate.viewContext)
        savedRecipe.name = recipe.name
        savedRecipe.urlPhoto = recipe.urlPhoto
        savedRecipe.urlRecipeDetails = recipe.urlRecipeDetail
        savedRecipe.ingredient = recipe.ingredient
        savedRecipe.cookingTime = Int16(recipe.cookingTime)
        try? AppDelegate.viewContext.save()
        
    }
    
}
