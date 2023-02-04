//
//  Configuration.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
struct Configuration {
    static let BASE_URL = "https://api.spoonacular.com"
    static let SERVER_ERROE = ""
    static let TOKEN = "123456"
    static let API_KEY = "5f20e951b30148d9812163a54d5b23d5"
    
    static let scheme = "dev"
}

struct Constants {
    static var serverError = "Problemas de conexión con el servidor, por favor intente más tarde"
    static var intenetError = "No hay conexión a internet, por favor verifique la red de datos del operador móvil o la conexión a la red Wifi"
    static var pleaseWait = "Por favor espere"
    static var information = "Información"
    static var timeOutTest = 60.0
    static var nofound = "No se encontró la receta"
    
}
