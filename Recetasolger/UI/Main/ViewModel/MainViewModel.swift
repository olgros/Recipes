//
//  MainViewModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import RxSwift

protocol MainViewModel: ViewModel {
    var recetasResponse: PublishSubject<[Receta]> {get set}
    func getRecetas()
    func naviteToDetail(idReceta: Int)
    func searchRecetas(value: String)
}
