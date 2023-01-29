//
//  RecetasUseCase.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol RecetasUseCase: UseCase{
    var repository: RecetasRepository? {get set}
    var delegate: RecetasProtocol? {get set}
    func getRecetas()
    func searchRecetas(value: String)
}



