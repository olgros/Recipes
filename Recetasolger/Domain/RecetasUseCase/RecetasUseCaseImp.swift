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
    var repositoryLocal: RecetasRepository?
    
    init(repository: RecetasRepository, repositoryLocal: RecetasRepository){
        self.repository = repository
        self.repositoryLocal = repositoryLocal
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
        
        repositoryLocal?.getRecetas().done { [unowned self]  recetas in
            
            if value == ""{
                self.delegate?.onSuccess(recetas: recetas)
                return
            }
            
            let search  = value.lowercased()
            var recetasSearch = [Receta]()
            let data = search.split(separator: " ")
            if data.count > 0 {
                for item in data {
                    let recetasFind = recetas.filter{($0.name?.lowercased() ?? "" ).contains(item) || ($0.ingredientes?.lowercased() ?? "" ).contains(item)}
                    
                    recetasSearch = append(recetas: recetasSearch, recetasFind: recetasFind)                  
                   
                }
            }            
            self.delegate?.onSuccess(recetas: recetasSearch)
            
        }.catch { error in
            if let customError = error as? CustomError {
                self.delegate?.onError(title: Constants.information, message: customError.message ?? Constants.serverError )
            } else {
                self.delegate?.onError(title: Constants.information, message: Constants.serverError)
            }
        } 
    }
    
    
    func append(recetas:Array<Receta>, recetasFind: Array<Receta>) -> [Receta]{
        var newRecetas = recetas
        for item in recetasFind{
            let exist = newRecetas.filter{$0.id! == item.id}.first
            if exist == nil {
                newRecetas.append(item)
            }
            
        }
        
        return newRecetas
    }
}
