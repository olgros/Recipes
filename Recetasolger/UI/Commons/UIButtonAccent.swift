//
//  UIButtonPrimary.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import UIKit

class UIButtonAccent: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 0.0
        layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        layer.backgroundColor = UIColor(named: "AccentColor")?.cgColor
        layer.cornerRadius = 16.0
        setTitleColor(UIColor.white, for: .normal)
        // clipsToBounds = true

    }
}
