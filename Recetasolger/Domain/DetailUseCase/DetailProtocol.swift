//
//  DetailProtocol.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol DetailProtocol{
    func onSuccess(recipeDetail: RecipeDetail)
    func onError(title: String, message: String)
}
