//
//  MoreImagesTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 31/03/23.
//

import UIKit

class MoreImagesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imagePageClickView: UIViewX!
    
    @IBOutlet weak var fileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
