//
//  FavoriteViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 30/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //var myFavorites = CoreRecipe.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        //CoreRecipe.all
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // CoreRecipe.all
        //print("nombre de favoris \(myFavorites.count)")
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreRecipe.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()}
        
        let recipe = CoreRecipe.all[indexPath.row]
        guard let name = recipe.name else {return UITableViewCell()}
        print("on est dans la cellule name \(name)")
        guard let urlPhoto = recipe.urlPhoto else {return UITableViewCell()}
        print("on est dans la cellule urlPhoto \(urlPhoto)")
        let cookingTime = Int(recipe.cookingTime) //else {return UITableViewCell()}
        print("on est dans la cellule cookingTime \(cookingTime)")
        guard let ingredient = recipe.ingredient else {return UITableViewCell()}
        print("on est dans la cellule ingredient \(ingredient)")
        
        cell.configure(withImage: urlPhoto, name: name, time: cookingTime, ingredients: ingredient)
        return cell
    }
    
  
}
extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("le nombre de favoris dans core Data est de \(CoreRecipe.all.count)")
        if CoreRecipe.all.count > 0 {
             performSegue(withIdentifier: "favoriteDetail", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check the segue name
        // si la destination est le VC DetailViewController, and set the index from the selected item
        if let dest = segue.destination as? RecipeDetailViewController, let row = tableView.indexPathForSelectedRow?.row {
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
