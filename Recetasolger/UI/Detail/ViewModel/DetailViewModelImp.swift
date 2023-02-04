//
//  DetailViewModelImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift


class DetailViewModelImp: DetailViewModel {
     
    let log  = Log(String(describing: DetailViewModelImp.self))
    var recipeResponse = PublishSubject<RecipeDetail>()
    
    var detailUseCase: DetailUseCase?
 
    var coordinator: DetailCoordiantorProtocol?
    var idRecipe: Int?
    init(coordinator: DetailCoordiantorProtocol, detailUseCase: DetailUseCase, idRecipe: Int) {
        self.coordinator = coordinator
        self.detailUseCase = detailUseCase
        self.idRecipe = idRecipe
        self.detailUseCase?.delegate = self
    }

    func viewDidLoad() {
        getRecipeDetail(idRecipe ?? 0)
    }

    func viewWillAppear() {
       
    }

    func viewDidAppear() {
       
    }    
    
    
    func isFavorite() -> Bool {
        return self.coordinator is FavoritesCoordinator
    }
    
    func getRecipeDetail(_ id: Int) {
        detailUseCase?.getRecipeDetail(id)
    }
    
    func saveFavorite(recipeDetail: RecipeDetail?){
        guard let recipe = recipeDetail else { return }
        if detailUseCase?.saveFavorite(recipeDetail: recipe) ?? false{
            if isFavorite() {
                coordinator?.onShowAlertMessage(title: Constants.information, message: "La receta fue eliminada de favoritos")
            }else{
                coordinator?.onShowAlertMessage(title: Constants.information, message: "La receta fue guardada en favoritos")
            }
        }
    }
              
}

extension DetailViewModelImp: DetailProtocol {
    func onSuccess(recipeDetail: RecipeDetail) {
        recipeResponse.onNext(recipeDetail)
    }
    func onError(title: String, message: String) {
        coordinator?.onShowAlertMessage(title: title, message: message)
    }
}
