//
//  DetailUseCaseImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
class DetailUseCaseImp: DetailUseCase {
    var delegate: DetailProtocol?
   
  
    var repository: RecipesRepository?
    
    init(repository: RecipesRepository){
        self.repository = repository
    }
    
    func getRecipeDetail(_ id: Int) {
        
        self.showSpinner()
        repository?.getDetailRecipe(id: id).done { [unowned self]  detailRecipes in
            if let detail = detailRecipes {
                self.delegate?.onSuccess(recipeDetail: detail)
            }else{
                self.delegate?.onError(title: Constants.information, message: Constants.serverError)
            }
        }.catch { error in
            if let customError = error as? CustomError {
                self.delegate?.onError(title: Constants.information, message: customError.message ?? Constants.serverError )
            } else {
                self.delegate?.onError(title: Constants.information, message: Constants.nofound)
            }

        }.finally {
            self.hideSpinner()
        }
    }
    
    func saveFavorite(recipeDetail: RecipeDetail) -> Bool{
        return repository?.saveFavorite(recipeDetailModel: RecipeDetailModel(recipeDetail: recipeDetail)) ?? false
    }
    
}
