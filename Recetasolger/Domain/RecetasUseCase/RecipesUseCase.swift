//
//  RecetasUseCase.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol RecipesUseCase: UseCase{
    var repository: RecipesRepository? {get set}
    var delegate: RecipesProtocol? {get set}
    func getRecipes(query: String)    
}



