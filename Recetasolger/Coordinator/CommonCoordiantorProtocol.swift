//
//  CommonCoordiantorDelegate.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
protocol CommonCoordiantorProtocol: AnyObject {
    func onShowAlertMessage(title: String?, message: String?)
    func navigateToRoot()
    func onBack()
}
