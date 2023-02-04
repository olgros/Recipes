//
//  RecipeDetail.swift
//  Recetasolger
//
//  Created by Olger Rosero on 3/02/23.
//

import Foundation
struct RecipeDetail: Codable {
    var vegetarian, vegan, glutenFree, dairyFree: Bool?
    var veryHealthy, cheap, veryPopular, sustainable: Bool?
    var lowFodmap: Bool?
    var weightWatcherSmartPoints: Int?
    var gaps: String?
    var preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int?
    var creditsText, license, sourceName: String?
    var pricePerServing: Double?
    var extendedIngredients: [ExtendedIngredient]?
    var id: Int?
    var title: String?
    var readyInMinutes, servings: Int?
    var sourceURL: String?
    var image: String?
    var imageType, summary: String?
    var dishTypes: [String]?
    var instructions: String?
    var spoonacularSourceURL: String?

    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap, weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore, creditsText, license, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, imageType, summary,  dishTypes,  instructions
       
        case spoonacularSourceURL = "spoonacularSourceUrl"
    }
    init(){
    }
    
    init(recipeDetailModel: RecipeDetailModel){
        self.id = recipeDetailModel.idRecipe
        self.title = recipeDetailModel.title
        self.summary = recipeDetailModel.summary
        self.image = recipeDetailModel.image
        extendedIngredients = [ExtendedIngredient]()
        for item in recipeDetailModel.ingredients {
            extendedIngredients?.append(ExtendedIngredient(ingredientModel: item))
        }
    }
}
