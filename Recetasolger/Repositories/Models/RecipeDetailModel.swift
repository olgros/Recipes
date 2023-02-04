//
//  RecipeDetailModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 4/02/23.
//

import Foundation
import RealmSwift
import SwiftUI
class RecipeDetailModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var idRecipe: Int
    @Persisted var title: String
    @Persisted var summary: String
    @Persisted var image: String
    @Persisted var ingredients = RealmSwift.List<IngredientModel>()
     
    convenience init(recipeDetail: RecipeDetail  ) {
        self.init()
        self.idRecipe = recipeDetail.id ?? 0
        self.title = recipeDetail.title ?? ""
        self.summary = recipeDetail.summary ?? ""
        self.image = recipeDetail.image ?? ""
        
        if let extendedIngredients = recipeDetail.extendedIngredients {
            for item in extendedIngredients {
                ingredients.append(IngredientModel(extendedIngredient: item))
            }
        }
         
   }
}
