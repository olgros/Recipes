//
//  RecetasLocalRepositoryImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 31/01/23.
//

import Foundation
import PromiseKit
class RecetasLocalRepositoryImp: RecetasRepository {
    
    func getRecetas() -> Promise<[Receta]> {
       
        return Promise { seal in
            
            if let recetas = RecetaData.shared.recetas {
                seal.resolve(recetas, nil)
            }else{
                seal.resolve([Receta](), nil)
            }
        }        
    }
}
