//
//  CoreRecipe.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 30/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Class CoreRecipe
/**
 This class enables to save, display and remove a recipe from favorite in CoreData
 */
class CoreRecipe: NSManagedObject {
    // MARK: - Properties
    /// Array of all favorite recipes saved in CoreData
    static var all :[CoreRecipe] {
        let request: NSFetchRequest<CoreRecipe> = CoreRecipe.fetchRequest()
        guard let favorites = try? AppDelegate.viewContext.fetch(request) else {return []}
        return favorites
    }
    // MARK: - Methods
    /**
     This function enables to save a recipe in CoreData
     - Parameter recipe: the recipe to save
     */
    static func saveToFavorite(recipe: MyRecipe){
        let savedRecipe = CoreRecipe(context: AppDelegate.viewContext)
        savedRecipe.name = recipe.name
        savedRecipe.urlPhoto = recipe.urlPhoto
        savedRecipe.urlRecipeDetails = recipe.urlRecipeDetail
        savedRecipe.ingredient = recipe.ingredient
        savedRecipe.cookingTime = Int16(recipe.cookingTime)
        try? AppDelegate.viewContext.save()
        print("le recette a été enregistrée en favori")
        print("le nombre de favoris est de \(CoreRecipe.all.count)")
    }
    /**
     This function enables to delete a recipe from CoreData
     - Parameter coreRecipe: the recipe to delete
     */
    static func removeFromFavorite(coreRecipe: CoreRecipe){
        if !CoreRecipe.all.isEmpty {
            AppDelegate.viewContext.delete(coreRecipe)
            try? AppDelegate.viewContext.save()
            print("le recette a été supprimée des favoris")
            print("le nombre de favoris est de \(CoreRecipe.all.count)")
        }
    }
    /**
     This function enables to check if a recipe is already in CoreData as a favorite
     - Parameter recipe: the recipe to check
     */
    static func checkIfRecipeIsAlreadyInFavorite(recipe: MyRecipe) -> Bool {
        let name = recipe.name
        print(name)
        var counter = 0
        for recipe in CoreRecipe.all where recipe.name == name {
            counter += 1
        }
        if counter > 0 {
            return true
        } else {
            return false
        }
    }
}


