//
//  DetailUseCase.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol DetailUseCase: UseCase{
    var repository: RecipesRepository? {get set}
    var delegate: DetailProtocol? {get set}
    func getRecipeDetail(_ id: Int)
    func saveFavorite(recipeDetail: RecipeDetail) -> Bool
}
