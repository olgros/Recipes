//
//  MainCoordiantorDelegate.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol MainCoordiantorProtocol: CommonCoordiantorProtocol {
    func navigateToDetail(idRecipe: Int)
    func navigateToFavorites()
    
}
