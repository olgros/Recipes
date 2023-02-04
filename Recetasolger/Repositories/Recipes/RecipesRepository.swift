//
//  RecetasRepository.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import PromiseKit
protocol RecipesRepository {
    func getRecipes(query: String) -> Promise <Recipe?>
    func getDetailRecipe(id: Int) -> Promise <RecipeDetail?>
    func saveFavorite(recipeDetailModel: RecipeDetailModel)  -> Bool
}
