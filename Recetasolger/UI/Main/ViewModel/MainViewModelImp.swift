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
    var recetasResponse = PublishSubject<[Receta]>()
    
    var recetasUseCase: RecetasUseCase?
 
    var coordinator: MainCoordiantorProtocol?
 
    
    init(coordinator: MainCoordiantorProtocol, recetasUseCase: RecetasUseCase) {
        self.coordinator = coordinator
        self.recetasUseCase = recetasUseCase
        self.recetasUseCase?.delegate = self
    }

    func viewDidLoad() {
        getRecetas()
    }

    func viewWillAppear() {
       
    }

    func viewDidAppear() {
       
    }
    
    func getRecetas() {
        recetasUseCase?.getRecetas()
    }
    
    func naviteToDetail(idReceta: Int){
        coordinator?.navigateToDetail(idReceta: idReceta)
    }
    
    func searchRecetas(value: String){
        recetasUseCase?.searchRecetas(value: value)
    }
      
}


extension MainViewModelImp: RecetasProtocol {
    func onSuccess(recetas: [Receta]) {
        recetasResponse.onNext(recetas)
    }
    
    func onError(title: String, message: String) {
        coordinator?.onShowAlertMessage(title: title, message: message)
    }   
    
}
