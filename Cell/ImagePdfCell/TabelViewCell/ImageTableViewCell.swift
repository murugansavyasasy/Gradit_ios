//
//  ImageTableViewCell.swift
//  GraditCircularImage
//
//  Created by MACBOOKPRO on 02/11/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var SendbyStack: UIStackView!
    @IBOutlet weak var AttachmentStack: UIStackView!
    @IBOutlet weak var DetailsStackview: UIStackView!
    @IBOutlet weak var sendByDefaultLabel: UILabel!
    @IBOutlet weak var redDotImageView: UIImageView!
    @IBOutlet weak var upArrowssImages: UIImageView!
    @IBOutlet weak var imageCellDateLabel: UILabel!
    @IBOutlet weak var plusoneLabl: UILabel!
    @IBOutlet weak var fileAtchNamelabl: UILabel!
    @IBOutlet weak var imageCellTimeLabel: UILabel!
    @IBOutlet weak var countImageView: UIView!
    @IBOutlet weak var imageCellDescripitionLabel: UILabel!
    @IBOutlet weak var imageCellTitelLabel: UILabel!
    @IBOutlet weak var sendByCellLabel: UILabel!
    @IBOutlet weak var viewTap: UIViewX!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageCellDescripitionLabel.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
