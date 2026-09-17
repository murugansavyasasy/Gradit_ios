//
//  countryTvCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

class countryTvCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var SelectionCheckbox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flagImageView.layer.cornerRadius = flagImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
