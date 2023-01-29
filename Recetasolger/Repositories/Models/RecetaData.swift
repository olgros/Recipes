//
//  RecetaModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
class RecetaData{
    
    var recetas: Array<Receta>?
    
    static var shared: RecetaData = {
           let instance = RecetaData()
           return instance
       }()
        
}
