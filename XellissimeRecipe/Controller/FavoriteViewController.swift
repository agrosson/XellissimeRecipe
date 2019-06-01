//
//  FavoriteViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 30/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import CoreData


// MARK: - Class FavoriteViewController
/**
 This class displays the list of favorite recipes of user
 */
class FavoriteViewController: UIViewController {
    // MARK: - Outlets  tableView
    /// TableView where recipes are displayed
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Bienvenu sur la liste des favoris. Le nombre de favoris est de \(CoreRecipe.all.count)")
        testIfEmptyFavorite()
        updateView()
    }
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Bienvenu sur la liste des favoris. Le nombre de favoris est de \(CoreRecipe.all.count)")
        testIfEmptyFavorite()
        updateView()
    }
    // MARK: - Methods
    private func testIfEmptyFavorite(){
        if CoreRecipe.all.count == 0 {
//            Alert.shared.controller = self
//            Alert.shared.alertDisplay = .noFavorites
            let actionSheet = UIAlertController(title: "Sorry", message: "No favorites", preferredStyle: .alert)
            
            actionSheet.addAction(UIAlertAction(title: "Search and click on forks to add to favorites", style: .cancel, handler: { (action: UIAlertAction) in
                  self.performSegue(withIdentifier: "backToMenu", sender: self)
            }))
            self.present(actionSheet, animated: true, completion : nil)
        }
    }
    /**
     Function that updates views and reloads data for tableView
     */
    fileprivate func updateView() {
        //tableView.estimatedRowHeight = tableView.rowHeight
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    /**
     UnWind segue target to current VC
     */
    @IBAction func backToFavorite(segue: UIStoryboardSegue){
    }
}
// MARK: - Extensions: protocole UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    /**
     Function that indicates number of section in tableView
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /**
     Function that indicates number of of rows in section in tableView
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreRecipe.all.count
    }
    /**
     Function that displays reusable cell in tableView
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a cell of type FavoriteTableViewCell
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "FavoriteCell",
                                                        for: indexPath) as? FavoriteTableViewCell
            else {return UITableViewCell()}
        // get the recipe from the Array "CoreRecipe.all" at index "indexPath.row"
        let recipe = CoreRecipe.all[indexPath.row]
        // Extract attributes from recipe to configure cell
        guard let name = recipe.name else {return UITableViewCell()}
        guard let urlPhoto = recipe.urlPhoto else {return UITableViewCell()}
        let cookingTime = Int(recipe.cookingTime)
        guard let ingredient = recipe.ingredient else {return UITableViewCell()}
        cell.configure(withImage: urlPhoto, name: name, time: cookingTime, ingredients: ingredient)
        return cell
    }
}
    // MARK: - Extensions: protocole UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    /**
     Function that executes actions when a cell is selected
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if CoreRecipe.all.count > 0 {
            performSegue(withIdentifier: "favoriteDetail", sender: self)
        }
    }
    /**
     Function that prepares the segue to transfer data (objects) from a current VC to another (here "RecipeDetailViewController")
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check the segue name
        // si la destination est le VC DetailViewController, and set the index from the selected item
        if let dest = segue.destination as? RecipeDetailViewController, let row = tableView.indexPathForSelectedRow?.row {
            // get recipe attributes of a recipe from coreData and create a MyRecipe object
            let recipe = CoreRecipe.all[row]
            guard let name = recipe.name else {return}
            guard let urlPhoto = recipe.urlPhoto else {return}
            let cookingTime = Int(recipe.cookingTime)
            guard let ingredient = recipe.ingredient else {return}
            guard let urlDetail = recipe.urlRecipeDetails else {return}
            let myRecipe = MyRecipe(name: name)
            myRecipe.cookingTime = cookingTime
            myRecipe.urlPhoto = urlPhoto
            myRecipe.ingredient = ingredient
            myRecipe.urlRecipeDetail = urlDetail
            let star = true
            dest.recipe = myRecipe
            dest.star = star
            dest.coreRecipe = recipe
        }
    }
}
