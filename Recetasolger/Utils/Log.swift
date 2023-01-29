//
//  Log.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import Foundation
import UIKit
struct Log {

    var className: String
    init(_ className: String) {
        self.className = className
    }

    func info(_ message: String) {
        show(type: "==INFO==", value: nil, message: message)
    }

    func error(_ message: String) {
       show(type: "==ERROR==", value: nil, message: message)
    }

    func info(value: String, message: String) {
       show(type: "==INFO==", value: value, message: message)
    }

    func error(value: String, message: String) {
       show(type: "==ERROR==", value: value, message: message)
    }

    func show(type: String, value: String?, message: String) {
        if Configuration.scheme == "dev" {
            if let value = value {
                print("\(type) : \(className) == \(value) ==  \(message)")
            } else {
                print("\(type) : \(className) == \(message)")
            }
        }
    }
}
