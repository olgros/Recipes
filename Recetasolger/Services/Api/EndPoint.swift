//
//  EndPoint.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
public enum EndPoint {

    case recetas
    case detail(String)
       
    public var resource: EndpointResurce {
        switch self {

        case .recetas:
           return (.get, "/recetas/list")
        case .detail(let value):
           return (.get, "/recetas/detail/\(value)")
        
        }
    }
}

