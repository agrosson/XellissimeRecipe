//
//  FavoriteViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 30/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // CoreFavorite.myFavorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeListTableViewCell else {return UITableViewCell()}
        
        let recipe = listOfRecipes[indexPath.row]
        
        cell.configure(withImage: recipe.urlPhoto, name: recipe.name, time: recipe.cookingTime, ingredients: recipe.ingredient)
        return cell
    }
}
