//
//  TitleViewCell.swift
//  Recetasolger
//
//  Created by Olger Rosero on 4/02/23.
//

import UIKit

class TitleViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var title: String? {
        didSet{
            guard let title = title else { return }
            lblTitle.text = title
        }
    }
}
