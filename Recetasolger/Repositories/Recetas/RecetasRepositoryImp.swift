//
//  RecetasRepositoryImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import PromiseKit
class RecetasRepositoryImp: RecetasRepository {    
    func getRecetas() -> Promise<[Receta]> {
        return NetworkManager.shared.arrayRequest(EndPoint.recetas.resource)
    }
}
