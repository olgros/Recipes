//
//  UILabelMultilineTop.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import Foundation
import UIKit
class UILabelMultilineTop:  UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
    }
    
    //Para alinear el texto al top
    override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }
        
        let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: font])
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
        
        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }
        
        super.drawText(in: newRect)
    }
}
