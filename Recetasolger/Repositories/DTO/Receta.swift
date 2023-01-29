//
//  RecetaDTO.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
struct Receta: Codable {
    var id: Int?
    var name: String?
    var image: String?
    var description: String?
    var ubication: Ubication?
    var ingredientes: String?
}
