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
        testIfEmptyFavorite()
        updateView()
    }
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        testIfEmptyFavorite()
        updateView()
    }
    // MARK: - Methods
    /**
     Function that displays an alert when there is no favorite's recipe
     */
    private func testIfEmptyFavorite(){
        if CoreRecipe.all.count == 0 {
            let actionSheet = UIAlertController(title: "Sorry", message: "No favorites\nClick on forks\nto add favorites", preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: "Go Search", style: .cancel, handler: { (action: UIAlertAction) in
                  self.performSegue(withIdentifier: "backToMenu", sender: self)
            }))
            self.present(actionSheet, animated: true, completion : nil)
        }
    }
    /**
     Function that updates views and reloads data for tableView
     */
    fileprivate func updateView() {
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
     Function that indicates number of rows in section in tableView
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
     Function that indicates if a cell can be edited
     */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /**
     Function that deletes a cell (row) by swiping (trailing)
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             let recipe = CoreRecipe.all[indexPath.row]
             CoreRecipe.removeFromFavorite(coreRecipe: recipe)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            testIfEmptyFavorite()
        }
    }
    /**
     Function that shares a recipe by swiping (leading)
     */
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareRecipe = UIContextualAction(style: .normal, title: "Share") { (action, view, nil) in
            let recipe = CoreRecipe.all[indexPath.row]
            guard let recipeUrl = recipe.urlRecipeDetails else {return}
            let activityController = UIActivityViewController(activityItems: ["Hi, I wanted to share with you this fantastic recipe :\(recipeUrl)\nEnjoy !!"], applicationActivities: nil)
            self.present(activityController, animated: true, completion:{
            })
        }
        return UISwipeActionsConfiguration(actions: [shareRecipe])
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
            guard let myRecipe = MyRecipe(name: name) else {return}
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
