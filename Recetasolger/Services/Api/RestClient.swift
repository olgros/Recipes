//
//  RestClient.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import Alamofire
public typealias EndpointResurce = (method: HTTPMethod, route: String)

public class RestClient {
    var baseURL: String
    let defaultHeader: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]

    public init() {
        baseURL = Configuration.BASE_URL
    }
}
