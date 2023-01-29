//
//  CustomError.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import Foundation
protocol OurErrorProtocol: LocalizedError {
    var message: String? { get }
    var code: Int { get }
    var statusCode: Int? { get }  
}

struct CustomError: OurErrorProtocol, Decodable {

    var message: String?
    var code: Int
    var statusCode: Int?
  
    
    init() {
        message = Constants.serverError
        code = 500
        statusCode = 500
    }

    var errorDescription: String {
        get { return message ?? ""}
        set { self.message = newValue}
    }
    var failureReason: String? {
        get { return message }
        set { self.message = newValue ?? Constants.serverError }
    }

    init(message: String?, code: Int, statusCode: Int) {
        self.message = message ?? "Error"
        self.code = code
        self.statusCode = statusCode
    }
}
