//
//  SettingsTests.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 04/06/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
import  CoreData
@testable import XellissimeRecipe

class SettingsTests: XCTestCase {

    // test removeFirstAndLastAndDoubleWhitespace() success
    func testGivenAStringWhenWhiteSpaceThenRemoveIt() {
        var testString = "  a  string  "
        let cleanString = "a string"
        testString.removeFirstAndLastAndDoubleWhitespace()
        XCTAssert(cleanString == testString)
    }
    //
    func testGivenAStringWhenWhiteSpaceThenRemoveItWithError() {
        var testString = "  a  string  "
        let cleanString = " a  string "
        testString.removeFirstAndLastAndDoubleWhitespace()
        XCTAssert(cleanString != testString)
    }

}
