//
//  ImageViewCell.swift
//  Recetasolger
//
//  Created by Olger Rosero on 3/02/23.
//

import UIKit
import AlamofireImage

class ImageViewCell: UITableViewCell {

    @IBOutlet weak var imageRecipe: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var urlImage: String? {
        didSet{
            guard let urlImage = urlImage else { return }
                       
            guard let url = URL(string: urlImage ) else { return }

            
            let placeholderImage = UIImage(named: "placeholder")!
          
            
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: imageRecipe.frame.size,
                radius: 20.0
            )

            imageRecipe.af.setImage(
                withURL: url,
                placeholderImage: placeholderImage,
                filter: filter
            )
        }
    }
    
}
