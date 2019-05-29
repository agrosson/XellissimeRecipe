//
//  NetworkingClientTest.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
@testable import XellissimeRecipe

class NetworkingClientTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenAnIngredientArray_WhenCreateAlamofireRequest_ThenUrlIsUpdated () {
        // Given
        let array = ["Tomato","chicken"]
        // when
        NetworkingClient.shared.search(with: array)
        // then
        XCTAssertTrue()
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
