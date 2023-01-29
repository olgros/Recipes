//
//  ViewModel.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol ViewModel {
     var responseError: CustomError? {get set}
     func viewDidLoad()
     func viewWillAppear()
     func viewDidAppear()
}

extension ViewModel{
    
    var responseError:CustomError? {
           get {
               return responseError
           }
           set {
               if responseError == nil {
                   self.responseError = CustomError()
               } else {
                   self.responseError = responseError
               }
           }
       }
    
    func showSpinner(){
       SwiftSpinner.show(Constants.pleaseWait, animated: true)
    }
    func hideSpinner(){
        SwiftSpinner.hide()
    }
}
