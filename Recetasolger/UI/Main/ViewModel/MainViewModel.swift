//
//  MainViewModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift

protocol MainViewModel: ViewModel {
    var recetasResponse: PublishSubject<Recipe> {get set}
    func getRecipes(query: String)
    func naviteToDetail(idRecipe: Int)
    func searchRecipes(value: String)
    func navigateToFavorites()
    func isFavorite() -> Bool
}
