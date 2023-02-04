//
//  Recipe.swift
//  Recetasolger
//
//  Created by Olger Rosero on 3/02/23.
//

import Foundation
struct Recipe: Codable {
    let results: [ResultRecipe]
    let offset, number, totalResults: Int
}
