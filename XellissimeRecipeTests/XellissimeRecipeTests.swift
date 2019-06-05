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
    }
    
    // Test if Duplicate favorite in database
    func testIfDuplicate(){
        //given that a recipe with name Pizza has been saved
        guard let recipe = MyRecipe(name: "Pizza") else {return}
        CoreRecipe.saveToFavorite(recipe: recipe)
        // when try to save same item
        guard let recipe2 = MyRecipe(name: "Pizza") else {return}
        // the testIsTrue
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe2)
        XCTAssertTrue(test)
    }
    
    // Test if non Duplicate favorite in database
    func testIfNoDuplicate(){
        //given that a recipe with unique name
        let uuid = UUID()
        guard let recipe = MyRecipe(name: "\(uuid)") else {return}
        // the testIsTrue
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe)
        XCTAssertFalse(test)
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
}
