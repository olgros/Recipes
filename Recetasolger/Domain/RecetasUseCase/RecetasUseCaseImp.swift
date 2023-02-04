//
//  RecipesUseCaseImp.swift
//  Recipesolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation


class RecipesUseCaseImp: RecipesUseCase {
   
    var delegate: RecipesProtocol?
    var repository: RecipesRepository?
     
    init(repository: RecipesRepository){
        self.repository = repository
    }
    
    func getRecipes(query: String) {
        self.showSpinner()
        repository?.getRecipes(query: query).done { [unowned self]  recipes in           
            self.delegate?.onSuccess(recipes: recipes)
        }.catch { error in
            if let customError = error as? CustomError {
                self.delegate?.onError(title: Constants.information, message: customError.message ?? Constants.serverError )
            } else {
                self.delegate?.onError(title: Constants.information, message: Constants.serverError)
            }

        }.finally {
            self.hideSpinner()
        }
    }
}
