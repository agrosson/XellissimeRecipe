//
//  RecipeDetailViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import SafariServices
import CoreData


// MARK: - Class RecipeDetailViewController
/**
 This class displays the details of a recipe
 */
class RecipeDetailViewController: UIViewController {
    // MARK: - Properties
    /// Recipe object of type CoreRecipe - recipe tagged as a favorite recipe
    var coreRecipe: CoreRecipe?
    /// Recipe object of type MyRecipe
    var recipe: MyRecipe?
    /// Variable to track if recipe is tagged as favorite
    var star = false
    // MARK: - Outlets - UILabel
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
   // MARK: - Outlets - UITextView
    @IBOutlet weak var recipeDescription: UITextView!
    // MARK: - Outlets - UIImageView
    @IBOutlet weak var recipePicture: UIImageView!
    // MARK: - Outlets - UIButton
    @IBOutlet weak var recipeOnSafari: UIButton!
    // MARK: - Methods - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(favoriteTapped))
        setupScreen()
    }
    // MARK: - Methods - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupScreen()
    }
    // MARK: - Actions
    /**
     Action that opens Safari and displays recipe directions on Internet
     */
    @IBAction func seeRecipeIsPressed(_ sender: Any) {
        guard let recipe = recipe else {
            return
        }
        showSafariVC(for: recipe.urlRecipeDetail)
    }
    // MARK: - Methods
    /**
     Function that executes favoriteSwitch() and displays list of favorites if recipe set to favorite
     */
    @objc func favoriteTapped(){
        favoriteSwitch()
    }
    /**
     Function that changes favorite status for a recipe : add or remove from favorite and update image (fork or star)
     */
    private func favoriteSwitch(){
        if  navigationItem.rightBarButtonItem!.image == UIImage(imageLiteralResourceName: "fork") {
            navigationItem.rightBarButtonItem!.image = UIImage(named: "favoriteSelected")
            star = true
            guard let recipe = recipe else {
                return
            }
            if CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe) == true {
                print("attention doublon")
            } else {
                print("Nickel pas de doublon")
                CoreRecipe.saveToFavorite(recipe: recipe)
                performSegue(withIdentifier: "backToFavorite", sender: self)
            }
        } else {
            navigationItem.rightBarButtonItem!.image = UIImage(named: "fork")
            star = false
            guard let recipe = recipe else {return}
            if CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe) == true {
                CoreRecipe.removeACoreRecipeFromMyRecipe(recipe: recipe)
            }
            if let coreRecipe = coreRecipe {
                CoreRecipe.removeFromFavorite(coreRecipe: coreRecipe)
            }
            performSegue(withIdentifier: "backToFavorite", sender: self)
        }
    }
    /**
     Function that sets up the main screen
     */
    private func setupScreen(){
        guard let recipe = recipe else {return}
        if CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe) == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favoriteSelected"), style: .plain, target: self, action: #selector(favoriteTapped))
            star = true
        } else {
            star = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "fork"), style: .plain, target: self, action: #selector(favoriteTapped))
        }
        if star {
            navigationItem.rightBarButtonItem!.image = UIImage(named: "favoriteSelected")
        }
        name.text = recipe.name
        var text = ""
        for item in recipe.ingredient {
            text += "\t\(item)\n"
        }
        recipeDescription.text = text
        recipePicture.translatesAutoresizingMaskIntoConstraints = false
        var width = CGFloat()
        if UIScreen.main.bounds.width > 400 {
             width = UIScreen.main.bounds.width/8
        } else {
                width = UIScreen.main.bounds.width/4
        }
        recipePicture.leftAnchor.constraint(equalTo: view.leftAnchor, constant: width).isActive = true
        recipePicture.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -width).isActive = true
        var imageToDisplay : UIImage?
        guard let url = URL(string: recipe.urlPhoto ) else {return}
        guard let data = try? Data(contentsOf: url) else {return}
        imageToDisplay = UIImage(data: data)
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
    /**
     Function that shows recipe on web site with safari
     */
    private func showSafariVC(for url: String){
        guard let url = URL(string: url) else {
            Alert.shared.controller = self
            Alert.shared.alertDisplay = .recipeDetailsUrlError
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
