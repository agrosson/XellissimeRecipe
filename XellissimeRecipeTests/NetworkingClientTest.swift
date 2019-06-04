//
//  NetworkingClientTest.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 29/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import XCTest
import CoreData
@testable import XellissimeRecipe

class NetworkingClientTest: XCTestCase {

    func testAlamofireOK(){
       // let expectation = self.expectation(description: "TestAlamo")
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.jsonCorrectDataUrl
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testAlamofireKONoName(){
        // let expectation = self.expectation(description: "TestAlamo")
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoName
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    
    
    
    
}
