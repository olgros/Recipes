//
//  DetailViewModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift
protocol DetailViewModel: ViewModel {
    var recetaResponse: PublishSubject<Receta> {get set}
    func getReceta(_ id: Int)
    func navigateToMap(receta: Receta?)
}
