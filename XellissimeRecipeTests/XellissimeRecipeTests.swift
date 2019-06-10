//
//  XellissimeRecipeTests.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 27/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
import CoreData
@testable import XellissimeRecipe

class XellissimeRecipeTests: XCTestCase {

    // Test if can create an instance of CoreRecipe
    func testInitCoreRecipe() {
        let instance = CoreRecipe()
        XCTAssertNotNil(instance)
    }
    
    // Test if container exists
    func testIfContainerExists() {
        let instance = AppDelegate.persistentContainer
        XCTAssertNotNil(instance)
    }
    
    // Test if context exists
    func testIfContextExists() {
        let instance = AppDelegate.viewContext
        XCTAssertNotNil(instance)
    }
    
    // Test to create a specific CoreRecipe object
    func testCreateACoreRecipeObjetc(){
        let object = CoreRecipe(context: AppDelegate.viewContext)
        object.name = "Pizza"
        object.ingredient = ["tomato","olive","bread"]
        object.cookingTime = Int16(20)
        object.urlPhoto = nil
        object.urlRecipeDetails = "http:Miam"
        XCTAssertNotNil(object)
    }
    
    
    // Test to save a recipe into Favorite
    func testToSaveARecipeAsAFavorite(){
        // Given
        let numberBefore = CoreRecipe.all.count
        // and
        guard let recipe = MyRecipe(name: "Pizza") else {return}
        // When save recipe
        CoreRecipe.saveToFavorite(recipe: recipe)
        // Then favorite number increases of 1 item
        let numberAfter = CoreRecipe.all.count
        XCTAssertEqual(numberAfter, numberBefore+1)
        guard let coreLast = CoreRecipe.all.last else {return}
        CoreRecipe.removeFromFavorite(coreRecipe: coreLast)
    }
    
    // Test if Duplicate favorite in database
    func testIfDuplicate(){
        //given that a recipe with name Pizza has been saved
        guard let recipe = MyRecipe(name: "Pizza") else {return}
        recipe.urlRecipeDetail = "urlTest"
        CoreRecipe.saveToFavorite(recipe: recipe)
        // when try to save same item
        guard let recipe2 = MyRecipe(name: "Pizza") else {return}
        // the testIsTrue
        recipe2.urlRecipeDetail = "urlTest"
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe2)
        XCTAssertTrue(test)
        guard let coreLast = CoreRecipe.all.last else {return}
        CoreRecipe.removeFromFavorite(coreRecipe: coreLast)
    }
    
    // Test if Duplicate favorite in database
    func testIfDuplicateNoBecauseOfURL(){
        //given that a recipe with name Pizza has been saved
        guard let recipe = MyRecipe(name: "Pizza") else {return}
        recipe.urlRecipeDetail = "urlTest"
        CoreRecipe.saveToFavorite(recipe: recipe)
        // when try to save same item
        guard let recipe2 = MyRecipe(name: "Pizza") else {return}
        // the testIsTrue
        recipe2.urlRecipeDetail = "urlTest&"
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe2)
        XCTAssertFalse(test)
    }
    
    
    // Test if non Duplicate favorite in database
    func testIfNoDuplicate(){
        //given that a recipe with unique name
        let uuid = UUID()
        guard let recipe = MyRecipe(name: "\(uuid)") else {return}
        // the testIsTrue
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe)
        XCTAssertFalse(test)
        guard let coreLast = CoreRecipe.all.last else {return}
        CoreRecipe.removeFromFavorite(coreRecipe: coreLast)
    }
    
    // test function remove
    func testRemoveItemFromFavorite(){
        // Given a item in database : firstOne
        guard let itemToDelete = CoreRecipe.all.first else {return}
        let numberBefore = CoreRecipe.all.count
        // When delete an item
        CoreRecipe.removeFromFavorite(coreRecipe: itemToDelete)
        // then the number of item in database is -1
        let numberAfter = CoreRecipe.all.count
        XCTAssertEqual(numberAfter, numberBefore-1)
    }
    
    // Test function remove a favorite CoreRecipe from a MyRecipe diplayed
    func testGivenAMyRecipeWhenAlreadyInFavoriteThenRemoveWhenClicOnFavoriteIcon() {
        let uuid = UUID()
        let uuidURl = UUID()
        guard let recipeToBeLast = MyRecipe(name: "\(uuid)") else {return}
        recipeToBeLast.urlRecipeDetail = "\(uuidURl)"
        CoreRecipe.saveToFavorite(recipe: recipeToBeLast)
        let numberFavoriteBefore = CoreRecipe.all.count
        guard let itemToCheck = CoreRecipe.all.last else {return}
        guard let name = itemToCheck.name else {return}
        guard let url = itemToCheck.urlRecipeDetails else {return}
        guard let itemMyRecipe = MyRecipe(name: name) else {return}
        itemMyRecipe.urlRecipeDetail = url
        CoreRecipe.removeACoreRecipeFromMyRecipe(recipe: itemMyRecipe)
        let numberAfter = CoreRecipe.all.count
        XCTAssertEqual(numberAfter, numberFavoriteBefore-1)
        guard let coreLast = CoreRecipe.all.last else {return}
        CoreRecipe.removeFromFavorite(coreRecipe: coreLast)
    }
}

