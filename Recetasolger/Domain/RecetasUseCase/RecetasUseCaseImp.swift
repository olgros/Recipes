//
//  RecetasUseCaseImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation


class RecetasUseCaseImp: RecetasUseCase {
   
    var delegate: RecetasProtocol?
    var repository: RecetasRepository?
     
    init(repository: RecetasRepository){
        self.repository = repository
    }
    
    func getRecetas() {
        self.showSpinner()
        repository?.getRecetas().done { [unowned self]  recetas in
            RecetaData.shared.recetas = recetas
            self.delegate?.onSuccess(recetas: recetas)
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
    
    func searchRecetas(value: String){
        repository?.searchRecetas(value: value).done { [unowned self]  recetas in
            
            self.delegate?.onSuccess(recetas: recetas)
            
        }.catch { error in
            if let customError = error as? CustomError {
                self.delegate?.onError(title: Constants.information, message: customError.message ?? Constants.serverError )
            } else {
                self.delegate?.onError(title: Constants.information, message: Constants.serverError)
            }
        }
    }    
}
