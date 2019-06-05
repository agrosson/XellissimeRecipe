//
//  FakeDataForAlamoFire.swift
//  XellissimeRecipeTests
//
//  Created by ALEXANDRE GROSSON on 04/06/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation
import  CoreData
@testable import XellissimeRecipe


class FakeNetworkResponseData {
    
    static var jsonCorrectDataUrl: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipe", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeNoName: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeNoName", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeEmptyJson: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeEmpty", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeNoHit: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeNoHit", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeNoDetails: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeNoDetails", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeNoTime: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeNoTime", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeBadFormat: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeBadFormat", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeNoUrl: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeNoUrl", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeNoIngredientLines: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeNoIngredientLines", withExtension: "json") else {return ""}
        return url.absoluteString
    }
    static var responseRecipeFakeNoImage: String {
        // retrieve bundle where FakeWeatherResponseData is
        let bundle = Bundle(for: FakeNetworkResponseData.self)
        // retrieve url of file to test
        guard let url = bundle.url(forResource: "responseRecipeFakeNoImage", withExtension: "json") else {return ""}
        return url.absoluteString
    }
}
