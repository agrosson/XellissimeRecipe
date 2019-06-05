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
    
    // Test create url
    func testCreateURLAsAStringFromArrayOfString(){
        let ingredients = ["cheese", "tomato"]
        let result = NetworkingClient.shared.createURL(with: ingredients)
        let stringExpected = "https://api.edamam.com/search?q=+cheese+tomato&app_id=7ba6f788&app_key=58fb0a71d4b3042d003fa99123a86f75&to=30"
        XCTAssertEqual(result, stringExpected)
    }


    // Test correct json file
    func testAlamofireOK(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.jsonCorrectDataUrl
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    // Test Json file with no recipe name
    func testAlamofireKONoName(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoName
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    // test empty Json File
    func testAlamofireFakeEmptyJsonFile(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeEmptyJson
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testAlamofireFakeNoHit(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoHit
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testAlamofireFakeNoDetails(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoDetails
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testAlamofireFakeBadFormat(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeBadFormat
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testAlamofireFakeNoUrl(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoUrl
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testAlamofireFakeNoTime(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoTime
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testAlamofireFakeNoIngredientLines(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoIngredientLines
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    func testAlamofireFakeNoImage(){
        let expectation = self.expectation(description: "Alamo")
        let url = FakeNetworkResponseData.responseRecipeFakeNoImage
        NetworkingClient.shared.search(with: url) { (success, recipes) in
            XCTAssertFalse(success)
            XCTAssertNil(recipes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
    }
    
}
