//
//  MapViewModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift
protocol MapViewModel: ViewModel {
    var recetaResponse: PublishSubject<RecetaAnnotation> {get set}
    var receta: Receta {get set}
}
