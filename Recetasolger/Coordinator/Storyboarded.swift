//
//  Storyboarded.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }

    static func instantiate(_ nameStoryBoard: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: nameStoryBoard, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
