//
//  IngredientViewCell.swift
//  Recetasolger
//
//  Created by Olger Rosero on 4/02/23.
//

import UIKit

class IngredientViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOriginaName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var ingredient: ExtendedIngredient? {
        didSet{
            guard let ingredient = ingredient else {
                return
            }

            lblName.text = ingredient.name
            lblOriginaName.text = ingredient.originalName
            lblAmount.text = "\(ingredient.amount) \(ingredient.unit)"            
            
        }
    }
}
