//
//  DetailUseCase.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol DetailUseCase: UseCase{
    var repository: DetailRepository? {get set}
    var delegate: DetailProtocol? {get set}
    func getReceta(_ id: Int)
}
