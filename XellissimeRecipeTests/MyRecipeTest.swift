//
//  RecipeTest.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 04/06/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
import  CoreData
@testable import XellissimeRecipe


class MyRecipeTest: XCTestCase {

    // Test if can create an instance of MyRecipe
    func testInitMyRecipe() {
        let name = "Pizza"
        let recipe = MyRecipe(name: name)
        
        XCTAssertNotNil(recipe)
    }
    
    // Test if can create an instance of MyRecipe
    func testInitMyRecipeWithEmptyString() {
        let name = ""
        let recipe = MyRecipe(name: name)
        XCTAssertNil(recipe)
    }

   // Create Recipe Object
    

}
