//
//  DetailRepository.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol DetailRepository {
    func getReceta(_ id: Int) -> Receta?
}
