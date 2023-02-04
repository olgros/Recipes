//
//  RecetasProtocol.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol RecipesProtocol{
    func onSuccess(recipes: Recipe?)
    func onError(title: String, message: String)
}
