//
//  MapViewModelImp.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift


class MapViewModelImp: MapViewModel {
             
    var recetaResponse = PublishSubject<RecetaAnnotation>()
    var coordinator: MapCoordiantorProtocol?
    var receta: Receta
    
    init(coordinator: MapCoordiantorProtocol, receta: Receta) {
        self.coordinator = coordinator
        self.receta = receta
    }

    func viewDidLoad() {
        recetaResponse.onNext(RecetaAnnotation(receta: receta))
    }

    func viewWillAppear() {
       
    }

    func viewDidAppear() {
       
    }
    
    func onBack(){
        coordinator?.onBack()
    }
        
      
}
