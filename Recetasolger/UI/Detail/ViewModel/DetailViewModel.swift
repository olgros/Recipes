//
//  DetailViewModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift
protocol DetailViewModel: ViewModel {
    var detailUseCase: DetailUseCase? {get set}
    var recipeResponse: PublishSubject<RecipeDetail> {get set}
    func getRecipeDetail(_ id: Int)
    func saveFavorite(recipeDetail: RecipeDetail?)   
    func isFavorite() -> Bool
}
