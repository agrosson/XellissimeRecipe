//
//  Recipe.swift
//  XellissimeRecipe
//
//  Created by ALEXANDRE GROSSON on 28/05/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import Foundation


class Favorite {
    var myFavorite = [MyRecipe]()
}



class MyRecipe {
    
    var name : String
    var urlPhoto = String()
    var urlRecipeDetail = String()
    var ingredient = [String:String]()
    var cookingTime = String()
    
    init(name: String) {
        self.name = name
    }
}


// MARK: - RecipeResponse
class RecipeResponse: Codable {
    let q: String?
    let from, to: Int?
    let params: Params?
    let more: Bool?
    let count: Int?
    let hits: [Hit]?
    
    init(q: String?, from: Int?, to: Int?, params: Params?, more: Bool?, count: Int?, hits: [Hit]?) {
        self.q = q
        self.from = from
        self.to = to
        self.params = params
        self.more = more
        self.count = count
        self.hits = hits
    }
}

// MARK: - Hit
class Hit: Codable {
    let recipe: Recipe?
    let bookmarked, bought: Bool?
    
    init(recipe: Recipe?, bookmarked: Bool?, bought: Bool?) {
        self.recipe = recipe
        self.bookmarked = bookmarked
        self.bought = bought
    }
}

// MARK: - Recipe
class Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels: [DietLabel]?
    let healthLabels: [HealthLabel]?
    let cautions, ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories, totalWeight: Double?
    let totalTime: Int?
    let totalNutrients, totalDaily: [String: Total]?
    let digest: [Digest]?
    
    init(uri: String?, label: String?, image: String?, source: String?, url: String?, shareAs: String?, yield: Int?, dietLabels: [DietLabel]?, healthLabels: [HealthLabel]?, cautions: [String]?, ingredientLines: [String]?, ingredients: [Ingredient]?, calories: Double?, totalWeight: Double?, totalTime: Int?, totalNutrients: [String: Total]?, totalDaily: [String: Total]?, digest: [Digest]?) {
        self.uri = uri
        self.label = label
        self.image = image
        self.source = source
        self.url = url
        self.shareAs = shareAs
        self.yield = yield
        self.dietLabels = dietLabels
        self.healthLabels = healthLabels
        self.cautions = cautions
        self.ingredientLines = ingredientLines
        self.ingredients = ingredients
        self.calories = calories
        self.totalWeight = totalWeight
        self.totalTime = totalTime
        self.totalNutrients = totalNutrients
        self.totalDaily = totalDaily
        self.digest = digest
    }
}

enum DietLabel: String, Codable {
    case highProtein = "High-Protein"
    case lowCarb = "Low-Carb"
    case lowFat = "Low-Fat"
}

// MARK: - Digest
class Digest: Codable {
    let label, tag: String?
    let schemaOrgTag: SchemaOrgTag?
    let total: Double?
    let hasRDI: Bool?
    let daily: Double?
    let unit: Unit?
    let sub: [Digest]?
    
    init(label: String?, tag: String?, schemaOrgTag: SchemaOrgTag?, total: Double?, hasRDI: Bool?, daily: Double?, unit: Unit?, sub: [Digest]?) {
        self.label = label
        self.tag = tag
        self.schemaOrgTag = schemaOrgTag
        self.total = total
        self.hasRDI = hasRDI
        self.daily = daily
        self.unit = unit
        self.sub = sub
    }
}

enum SchemaOrgTag: String, Codable {
    case carbohydrateContent = "carbohydrateContent"
    case cholesterolContent = "cholesterolContent"
    case fatContent = "fatContent"
    case fiberContent = "fiberContent"
    case proteinContent = "proteinContent"
    case saturatedFatContent = "saturatedFatContent"
    case sodiumContent = "sodiumContent"
    case sugarContent = "sugarContent"
    case transFatContent = "transFatContent"
}

enum Unit: String, Codable {
    case empty = "%"
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

enum HealthLabel: String, Codable {
    case alcoholFree = "Alcohol-Free"
    case peanutFree = "Peanut-Free"
    case sugarConscious = "Sugar-Conscious"
    case treeNutFree = "Tree-Nut-Free"
}

// MARK: - Ingredient
class Ingredient: Codable {
    let text: String?
    let weight: Double?
    
    init(text: String?, weight: Double?) {
        self.text = text
        self.weight = weight
    }
}

// MARK: - Total
class Total: Codable {
    let label: String?
    let quantity: Double?
    let unit: Unit?
    
    init(label: String?, quantity: Double?, unit: Unit?) {
        self.label = label
        self.quantity = quantity
        self.unit = unit
    }
}

// MARK: - Params
class Params: Codable {
    let sane: [String]?
    let q, appKey, appID: [String]?
    
    enum CodingKeys: String, CodingKey {
        case sane, q
        case appKey = "app_key"
        case appID = "app_id"
    }
    
    init(sane: [String]?, q: [String]?, appKey: [String]?, appID: [String]?) {
        self.sane = sane
        self.q = q
        self.appKey = appKey
        self.appID = appID
    }
}
