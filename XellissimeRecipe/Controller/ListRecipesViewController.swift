//
//  ListREcipesViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

// MARK: - Class ListRecipesViewController
/**
 This class displays the list of recipes found after research
 */
class ListRecipesViewController: UIViewController  {
    // MARK: - Outlets - UITableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Methods - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    // MARK: - Methods - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - Extension - UITableViewDataSource
extension ListRecipesViewController: UITableViewDataSource {
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
        return listOfRecipes.count
    }
    /**
     Function that displays reusable cell in tableView
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeListTableViewCell else {return UITableViewCell()}
        let recipe = listOfRecipes[indexPath.row]
        cell.configure(withImage: recipe.urlPhoto, name: recipe.name, time: recipe.cookingTime, ingredients: recipe.ingredient)
        return cell
    }
}
// MARK: - Extension - UITableViewDelegate
extension ListRecipesViewController: UITableViewDelegate {
    /**
     Function that executes actions when a cell is selected
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showRecipeDetail", sender: self)
    }
    /**
     Function that prepares the segue to transfer data (objects) from a current VC to another (here "RecipeDetailViewController")
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check the segue name
            // si la destination est le VC DetailViewController, and set the index from the selected item
        if let dest = segue.destination as? RecipeDetailViewController, let row = tableView.indexPathForSelectedRow?.row {
            dest.recipe = listOfRecipes[row]
            }
        }
    
    
}
