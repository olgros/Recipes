//
//  EndPoint.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
public enum EndPoint {
    
    case recipes(String)
    case detail(Int)
    
    public var resource: EndpointResurce {
        switch self {
        case .detail(let id):
           return (.get, "/recipes/\(id)/information?includeNutrition=false&apiKey=\(Configuration.API_KEY)")
        case .recipes(let query):
            return (.get, "/recipes/complexSearch?query=\(query)&number=20&apiKey=\(Configuration.API_KEY)")
        
        }
    }
}

