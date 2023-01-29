//
//  Coordinator.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childs: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    func start()
    func push(_ view: UIViewController)
}

extension Coordinator {

    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator: Coordinator) {
        // Call this if a coordinator is done.
        for (index, child) in childs.enumerated() {
            if child === coordinator {
                childs.remove(at: index)
                break
            }
        }
    }
}
