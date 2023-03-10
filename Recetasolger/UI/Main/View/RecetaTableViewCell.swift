//
//  RecetaTableViewCell.swift
//  Recetasolger
//
//  Created by Olger Rosero on 29/01/23.
//

import UIKit
import AlamofireImage

class RecetaTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageReceta: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var resultRecipe: ResultRecipe? {
        didSet {
            guard let resultRecipe = resultRecipe else { return }
            nameLabel.text = resultRecipe.title
            
            let urlImage = resultRecipe.image
            let url = URL(string: urlImage )!
            
            let placeholderImage = UIImage(named: "placeholder")!

            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: imageReceta.frame.size,
                radius: 20.0
            )

            imageReceta.af.setImage(
                withURL: url,
                placeholderImage: placeholderImage,
                filter: filter
            )            
                     
        }
    }
}
