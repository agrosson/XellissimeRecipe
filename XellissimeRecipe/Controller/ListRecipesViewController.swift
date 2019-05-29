//
//  ListREcipesViewController.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class ListRecipesViewController: UIViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(listOfRecipes.count)
        print(listOfRecipes)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension ListRecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeListTableViewCell else {return UITableViewCell()}
        
        let recipe = listOfRecipes[indexPath.row]
        
        cell.configure(withImage: recipe.urlPhoto, name: recipe.name, time: recipe.cookingTime, ingredients: recipe.ingredient)
        return cell
    }
}
