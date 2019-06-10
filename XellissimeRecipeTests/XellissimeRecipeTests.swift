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
        let testCountBaseInit = CoreRecipe.all.count
        let instance = CoreRecipe()
        XCTAssertNotNil(instance)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    // Test if container exists
    func testIfContainerExists() {
        let testCountBaseInit = CoreRecipe.all.count
        let instance = AppDelegate.persistentContainer
        XCTAssertNotNil(instance)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    // Test if context exists
    func testIfContextExists() {
        let testCountBaseInit = CoreRecipe.all.count
        let instance = AppDelegate.viewContext
        XCTAssertNotNil(instance)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    // Test to create a specific CoreRecipe object
    func testCreateACoreRecipeObjetc(){
        let testCountBaseInit = CoreRecipe.all.count
        let object = CoreRecipe(context: AppDelegate.viewContext)
        object.name = "Pizza"
        object.ingredient = ["tomato","olive","bread"]
        object.cookingTime = Int16(20)
        object.urlPhoto = nil
        object.urlRecipeDetails = "http:Miam"
        XCTAssertNotNil(object)
        CoreRecipe.removeFromFavorite(coreRecipe: object)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    
    // Test to save a recipe into Favorite
    func testToSaveARecipeAsAFavorite(){
        let testCountBaseInit = CoreRecipe.all.count
        // Given
        let numberBefore = CoreRecipe.all.count
        // and
        let uuid = UUID()
        guard let recipe = MyRecipe(name: "\(uuid)") else {return}
        // When save recipe
        CoreRecipe.saveToFavorite(recipe: recipe)
        // Then favorite number increases of 1 item
        let numberAfter = CoreRecipe.all.count
        XCTAssertEqual(numberAfter, numberBefore+1)
        // remove after test
        CoreRecipe.removeACoreRecipeFromMyRecipe(recipe: recipe)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    // Test if Duplicate favorite in database
    func testIfDuplicate(){
        let testCountBaseInit = CoreRecipe.all.count
        //given that a recipe with name Pizza has been saved
        let uuid = UUID()
        guard let recipe = MyRecipe(name: "\(uuid)") else {return}
        recipe.urlRecipeDetail = "urlTest"
        CoreRecipe.saveToFavorite(recipe: recipe)
        // when try to save same item
        guard let recipe2 = MyRecipe(name: "\(uuid)") else {return}
        // the testIsTrue
        recipe2.urlRecipeDetail = "urlTest"
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe2)
        XCTAssertTrue(test)
        CoreRecipe.removeACoreRecipeFromMyRecipe(recipe: recipe)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    // Test if Duplicate favorite in database
    func testIfDuplicateNoBecauseOfURL(){
        let testCountBaseInit = CoreRecipe.all.count
        //given that a recipe with name Pizza has been saved
        let uuid = UUID()
        guard let recipe = MyRecipe(name: "\(uuid)") else {return}
        recipe.urlRecipeDetail = "urlTest"
        CoreRecipe.saveToFavorite(recipe: recipe)
        // when try to save same item
        guard let recipe2 = MyRecipe(name: "\(uuid)") else {return}
        // the testIsTrue
        recipe2.urlRecipeDetail = "urlTest&"
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe2)
        XCTAssertFalse(test)
        CoreRecipe.removeACoreRecipeFromMyRecipe(recipe: recipe)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    
    // Test if non Duplicate favorite in database
    func testIfNoDuplicate(){
        let testCountBaseInit = CoreRecipe.all.count
        //given that a recipe with unique name
        let uuid = UUID()
        guard let recipe = MyRecipe(name: "\(uuid)") else {return}
        // the testIsTrue
        let test = CoreRecipe.checkIfRecipeIsAlreadyInFavorite(recipe: recipe)
        XCTAssertFalse(test)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    // test function remove
    func testRemoveItemFromFavorite(){
        let testCountBaseInit = CoreRecipe.all.count
        let uuid = UUID()
        guard let recipe = MyRecipe(name: "\(uuid)") else {return}
        recipe.urlRecipeDetail = "urlTest"
        CoreRecipe.saveToFavorite(recipe: recipe)
        // Given a item in database : firstOne
        guard let itemToDelete = CoreRecipe.all.last else {return}
        let numberBefore = CoreRecipe.all.count
        // When delete an item
        CoreRecipe.removeFromFavorite(coreRecipe: itemToDelete)
        // then the number of item in database is -1
        let numberAfter = CoreRecipe.all.count
        XCTAssertEqual(numberAfter, numberBefore-1)
        let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
    
    // Test function remove a favorite CoreRecipe from a MyRecipe diplayed
    func testGivenAMyRecipeWhenAlreadyInFavoriteThenRemoveWhenClicOnFavoriteIcon() {
        let testCountBaseInit = CoreRecipe.all.count
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
         let testCountBaseFinal = CoreRecipe.all.count
        XCTAssertEqual(testCountBaseInit, testCountBaseFinal)
    }
}

