//
//  UseCase.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol UseCase{
    
}

extension UseCase {
    func showSpinner(){
       SwiftSpinner.show(Constants.pleaseWait, animated: true)
    }
    func hideSpinner(){
        SwiftSpinner.hide()
    }
}
