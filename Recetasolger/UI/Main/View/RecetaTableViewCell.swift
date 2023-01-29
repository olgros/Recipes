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
    
    var receta: Receta? {
        didSet {
            guard let receta = receta else { return }
            nameLabel.text = receta.name
            
            guard  let urlImage = receta.image else { return }
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
