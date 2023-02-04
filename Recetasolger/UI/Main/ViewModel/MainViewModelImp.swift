//
//  MainViewModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import UIKit
import RxSwift


class MainViewModelImp: MainViewModel {
       
    let log  = Log(String(describing: MainViewModelImp.self))
    var recetasResponse = PublishSubject<Recipe>()
    
    var recipesUseCase: RecipesUseCase? 
    var coordinator: MainCoordiantorProtocol?
 
    
    init(coordinator: MainCoordiantorProtocol, recipesUseCase: RecipesUseCase) {
        self.coordinator = coordinator
        self.recipesUseCase = recipesUseCase
        self.recipesUseCase?.delegate = self
    }

    func viewDidLoad() {
         getRecipes(query: "")
    }

    func viewWillAppear() {
    }

    func viewDidAppear() {
    }
    
    func isFavorite() -> Bool{
        return coordinator is FavoritesCoordinator
    }
    
    func getRecipes(query: String) {
        recipesUseCase?.getRecipes(query: query)
    }
    
    func naviteToDetail(idRecipe: Int){
        coordinator?.navigateToDetail(idRecipe: idRecipe)
    }
    
    func searchRecipes(value: String){
        recipesUseCase?.getRecipes(query: value)
    }
    
    func navigateToFavorites(){
        coordinator?.navigateToFavorites()
    }
      
}


extension MainViewModelImp: RecipesProtocol {
    func onSuccess(recipes: Recipe?) {
        guard let recipes = recipes else { return }
        recetasResponse.onNext(recipes)
    }
    
    func onError(title: String, message: String) {
        coordinator?.onShowAlertMessage(title: title, message: message)
    }   
    
}
