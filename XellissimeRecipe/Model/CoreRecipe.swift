//
//  CoreRecipe.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 30/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import CoreData

class CoreRecipe: NSManagedObject {
    
    static var all :[CoreRecipe] {
        let request: NSFetchRequest<CoreRecipe> = CoreRecipe.fetchRequest()
        guard let favorites = try? AppDelegate.viewContext.fetch(request) else {return []}
        return favorites
    }
    static func delete(_ thisRecipe: CoreRecipe){
        AppDelegate.viewContext.delete(thisRecipe)
        try? AppDelegate.viewContext.save()
    }
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
    static func removeFromFavorite(coreRecipe: CoreRecipe){
        if CoreRecipe.all.count > 0 {
            AppDelegate.viewContext.delete(coreRecipe)
            try? AppDelegate.viewContext.save()
            print("le recette a été supprimée des favoris")
            print("le nombre de favoris est de \(CoreRecipe.all.count)")
        }
    }
}


