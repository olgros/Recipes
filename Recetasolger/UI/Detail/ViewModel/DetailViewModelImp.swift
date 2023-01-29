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
    var recetaResponse = PublishSubject<Receta>()
    
    var detailUseCase: DetailUseCase?
 
    var coordinator: DetailCoordiantorProtocol?
    var idReceta: Int?
    init(coordinator: DetailCoordiantorProtocol, detailUseCase: DetailUseCase, idReceta: Int) {
        self.coordinator = coordinator
        self.detailUseCase = detailUseCase
        self.idReceta = idReceta
        self.detailUseCase?.delegate = self
    }

    func viewDidLoad() {
        getReceta(idReceta ?? 0)
    }

    func viewWillAppear() {
       
    }

    func viewDidAppear() {
       
    }
    
    func getReceta(_ id: Int) {
        detailUseCase?.getReceta(id)
    }
    
    func navigateToMap(receta: Receta?){
        guard let receta = receta else {
            coordinator?.onShowAlertMessage(title: Constants.information, message: "No ha seleccionado ninguan receta")
            return
        }
        coordinator?.navigateToMap(receta: receta)
    }
      
}

extension DetailViewModelImp: DetailProtocol {
    func onSuccess(receta: Receta) {
        recetaResponse.onNext(receta)
    }
    func onError(title: String, message: String) {
        coordinator?.onShowAlertMessage(title: title, message: message)
    }
}
