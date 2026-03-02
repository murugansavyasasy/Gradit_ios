//
//  NextPageTVTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/01/24.
//

import UIKit

class NextPageTVTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timeAndDateLbl: UILabel!
    @IBOutlet weak var msgContent: UILabel!
    
    @IBOutlet weak var DiscreptionLbl: UILabel!
    
    @IBOutlet weak var sendView: UIViewX!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
