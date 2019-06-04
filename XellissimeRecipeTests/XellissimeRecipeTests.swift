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
    // test function delete
    func testDeleteItem(){
        // Given a item in database : firstOne
        guard let itemToDelete = CoreRecipe.all.first else {return}
        let numberBefore = CoreRecipe.all.count
        // When delete an item
        CoreRecipe.delete(itemToDelete)
        // then the number of item in database is -1
        let numberAfter = CoreRecipe.all.count
        XCTAssertEqual(numberAfter, numberBefore-1)
    }
    
    
    func testRequest() {
        
    }
    
    
    
    /*
    /*This test case inserts a person record*/
    func testAddIntoDataBaseFavorite() {
        
        //Given the name & ssn
        let name1 = "Alok"
        let ssn1 = 123
        
        let name2 = "Naitvik"
        let ssn2 = 456
        
        let name3 = "Deepti"
        let ssn3 = 789
        
        let person1 = coreDataManager.insertPerson(name: name1, ssn: Int16(ssn1))
        
        /*Asserts that an expression is not nil.
         Generates a failure when expression == nil.*/
        XCTAssertNotNil( person1 )
        
        let person2 = coreDataManager.insertPerson(name: name2, ssn: Int16(ssn2))
        
        /*Asserts that an expression is not nil.
         Generates a failure when expression == nil.*/
        XCTAssertNotNil( person2 )
        
        let person3 = coreDataManager.insertPerson(name: name3, ssn: Int16(ssn3))
        
        /*Asserts that an expression is not nil.
         Generates a failure when expression == nil.*/
        XCTAssertNotNil( person3 )
        
    }
    
    /*This test case fetches all person records*/
    func test_fetch_all_person() {
        
        //get personRecord already saved
        
        let results = coreDataManager.fetchAllPersons()
        
        //Assert return numbers of todo items
        //Asserts that two optional values are equal.
        XCTAssertEqual(results?.count, 3)
    }
    */
}
