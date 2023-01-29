//
//  RecetasProtocol.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol RecetasProtocol{
    func onSuccess(recetas: [Receta])
    func onError(title: String, message: String)
}
