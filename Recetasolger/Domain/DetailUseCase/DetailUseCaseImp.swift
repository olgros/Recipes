//
//  DetailUseCaseImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
class DetailUseCaseImp: DetailUseCase {
    var delegate: DetailProtocol?
   
  
    var repository: DetailRepository?
    
    init(repository: DetailRepository){
        self.repository = repository
    }
    
    func getReceta(_ id: Int) {
        if let receta = repository?.getReceta(id) {
            delegate?.onSuccess(receta: receta)
        }else{
            delegate?.onError(title: Constants.information, message: "No se encontró la receta con id:  \(id)")
        }
    }
    
}
