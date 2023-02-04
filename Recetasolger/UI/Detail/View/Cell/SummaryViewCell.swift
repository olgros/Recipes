//
//  DescriptionViewCell.swift
//  Recetasolger
//
//  Created by Olger Rosero on 3/02/23.
//

import UIKit

class SummaryViewCell: UITableViewCell {
    @IBOutlet weak var lblSummary: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var summary: String?{
        didSet{
            guard let summary = summary else { return }
            lblSummary.attributedText = summary.htmlToAttributedString
        }
    }
    
}
