//
//  NetworkManager+Extensions.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import Alamofire
extension NetworkManager: RequestInterceptor {

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest        
        let bearerToken = "Bearer \(Configuration.TOKEN)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }
}
