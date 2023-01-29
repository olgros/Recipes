//
//  DetailRepositoryImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
class DetailRepositoryImp: DetailRepository {
    
    func getReceta(_ id: Int) -> Receta? {
                
        let receta = RecetaData.shared.recetas?.filter{$0.id == id}.first
        
        return  receta
    }
}
