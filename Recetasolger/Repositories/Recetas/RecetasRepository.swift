//
//  RecetasRepository.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import PromiseKit
protocol RecetasRepository {
    func getRecetas() -> Promise <[Receta]>   
}
