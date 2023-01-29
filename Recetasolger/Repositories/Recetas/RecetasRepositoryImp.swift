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
    
    func searchRecetas(value: String) ->  Promise <[Receta]> {
     
        return Promise { seal in
            
            if value == ""{
                seal.resolve(RecetaData.shared.recetas, nil)
            }else{
                
                let search  = value.lowercased()
                var recetasSearch = [Receta]()
                let data = search.split(separator: " ")
                if data.count > 0 {
                    for item in data {
                        if let recetas = RecetaData.shared.recetas?.filter{($0.name?.lowercased() ?? "").contains(item) || ($0.ingredientes?.lowercased() ?? "").contains(item)} {
                            
                            recetasSearch = append(recetas: recetasSearch, recetasFind: recetas)
                        }
                    }
                }
                seal.resolve(recetasSearch, nil)
            }
        }
            
    }
    
    func append(recetas:Array<Receta>, recetasFind: Array<Receta>) -> [Receta]{
        var newRecetas = recetas
        for item in recetasFind{
            let exist = newRecetas.filter{$0.id! == item.id}.first
            if exist == nil {
                newRecetas.append(item)
            }
            
        }
        
        return newRecetas
    }
}
