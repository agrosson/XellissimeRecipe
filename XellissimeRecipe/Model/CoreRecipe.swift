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
}


