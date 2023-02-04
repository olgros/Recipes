//
//  ExtendedIngredient.swift
//  Recetasolger
//
//  Created by Olger Rosero on 3/02/23.
//

import Foundation
struct ExtendedIngredient: Codable {
    var id: Int?
    var aisle, image: String?
    var name, nameClean, original, originalName: String?
    var amount: Double
    var unit: String
    
    init(ingredientModel: IngredientModel){
        self.name = ingredientModel.name
        self.originalName = ingredientModel.originalName
        self.amount = ingredientModel.amount
        self.unit = ingredientModel.unit
        self.original = ingredientModel.originalName
        self.nameClean = ingredientModel.name
    }
    
    init(){
        amount = 0
        unit = ""
    }
}
